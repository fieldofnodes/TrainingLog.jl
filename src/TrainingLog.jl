module TrainingLog

    using Revise
    using TrainingContent: TrainingTableData

export
    write_table_to_file,
    generate_table



    function generate_table_row(week_idx::Int, content_type::String, content_title::String)
        return "Week\t&\t$week_idx\t&\t$content_type\t&\t$content_title\t\\\\"
    end


    function generate_table_header()
        return """
        \\newgeometry{margin=1cm} % modify this if you need even more space
        \\begin{landscape}
        \\begin{center}
        {\\renewcommand{\\arraystretch}{6}%
        \\begin{longtable}
        {
            |p{.1\\textwidth}
            |p{.25\\textwidth}
            |p{.175\\textwidth}
            |p{.4\\textwidth}
            |p{.225\\textwidth}|
        }
        %-------------------------------------------------------------------------------------------
        % FIRST HEADER Information
        %-------------------------------------------------------------------------------------------
        \\hline 
            \\multicolumn{1}
                {|p{.1\\textwidth}|}
                {\\centering \\textbf{Week}} 
            & 
            \\multicolumn{1}
                {p{.25\\textwidth}|}
                {\\centering \\textbf{Training \\\\ Competency}} 
            & 
            \\multicolumn{1}
                {p{.175\\textwidth}|}
                {\\centering \\textbf{Competency \\\\ Achieved \\\\(YES or NO)}}
            & 
            \\multicolumn{1}
                {p{.4\\textwidth}|}
                {\\centering \\textbf{Comments}} 
            & 
            \\multicolumn{1}
                {p{.225\\textwidth}|}
                {\\centering \\textbf{Trainer \\\\ Name \\\\ Signature}}\\\\ 
            \\hline 
            \\endhead
        %-------------------------------------------------------------------------------------------
        % Footer Information
        %-------------------------------------------------------------------------------------------
        %\\hline \\multicolumn{5}{|r|}{{Continued on next page}} \\\\ \\hline
        %\\endfoot
        \\endlastfoot
        """
    end

    function generate_table_footer()
        return """
        \\hline
        \\end{longtable}
        \\restoregeometry}
        \\end{center}
        \\end{landscape}
        \\restoregeometry
        """
    end


    function generate_table(ttd::TrainingTableData)
        week_idx, content_type, content_title = ttd.week_idx, ttd.content_type, ttd.content_title
        contents = Base.OneTo(length(content_title))
        
        header = generate_table_header()
        rows = 
            [generate_table_row(week_idx[i], content_type[i], content_title[i]) for i in contents] |>
            x -> join(x,"\n")
        footer = generate_table_footer()
        
        return join([header,rows,footer], "\n")
    end

    function write_table_to_file(filename::String,ttd::TrainingTableData)
        table = generate_table(ttd)
        open(filename, "w") do file
            write(file, table)
        end
    end


end
