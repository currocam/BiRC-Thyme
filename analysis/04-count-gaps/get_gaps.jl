using FASTX, BioSequences, Test, DataFrames, CSV


function count_gaps!(gaps, s)
    arr = findall(DNA_N, s)
    n = length(arr)
    if n == 0
        return 
    end
    push!(gaps, 1)
    for i in 2:n
        if arr[i] == arr[i-1] + 1
            gaps[end] += 1
        else
            push!(gaps, 1)
        end
    end
end


@testset "count_gaps!" begin
    gaps = Vector{Int}()

    count_gaps!(gaps, dna"ATTTCG")
    @test length(gaps) == 0

    count_gaps!(gaps, dna"NNN")
    @test gaps == [3]

    count_gaps!(gaps, dna"AAA")
    @test gaps == [3]

    count_gaps!(gaps, dna"TAGAAGANTAGAAGANNTAGAAGA")
    @test gaps == [3, 1, 2]
end

path = "../../results/ragtag_scaffold/scaffold_10k_q30_GCA_024222315_infergaps/ragtag.scaffold.fasta"
FASTAReader(open(path)) do reader
    contigs = Vector{String}()
    gaps = Vector{Int}()
    for record in reader
        if !occursin("_RagTag", identifier(record))
            continue
        end
        original_size = length(gaps)
        count_gaps!(gaps, sequence(LongDNA{4}, record))
        n_inserted_entries = length(gaps)-original_size
        while n_inserted_entries > 0
            push!(contigs, identifier(record))
            n_inserted_entries-=1
        end
    end
    df = DataFrame(chromosomes = contigs, n_gaps = gaps)
    CSV.write("gaps_ragtag_assembly.csv", df)
end