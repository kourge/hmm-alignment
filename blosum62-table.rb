Protein::Scoring::BLOSUM62 = lambda do |x, y|
  return -4 if x == '-' || y == '-'

  if false

  elsif x == 'A'
    if false
    elsif y == 'A'; return 4
    elsif y == 'R'; return -1
    elsif y == 'N'; return -2
    elsif y == 'D'; return -2
    elsif y == 'C'; return 0
    elsif y == 'Q'; return -1
    elsif y == 'E'; return -1
    elsif y == 'G'; return 0
    elsif y == 'H'; return -2
    elsif y == 'I'; return -1
    elsif y == 'L'; return -1
    elsif y == 'K'; return -1
    elsif y == 'M'; return -1
    elsif y == 'F'; return -2
    elsif y == 'P'; return -1
    elsif y == 'S'; return 1
    elsif y == 'T'; return 0
    elsif y == 'W'; return -3
    elsif y == 'Y'; return -2
    elsif y == 'V'; return 0
    elsif y == 'B'; return -2
    elsif y == 'Z'; return -1
    elsif y == '*'; return -4
    else; return 0
    end

  elsif x == 'R'
    if false
    elsif y == 'A'; return -1
    elsif y == 'R'; return 5
    elsif y == 'N'; return 0
    elsif y == 'D'; return -2
    elsif y == 'C'; return -3
    elsif y == 'Q'; return 1
    elsif y == 'E'; return 0
    elsif y == 'G'; return -2
    elsif y == 'H'; return 0
    elsif y == 'I'; return -3
    elsif y == 'L'; return -2
    elsif y == 'K'; return 2
    elsif y == 'M'; return -1
    elsif y == 'F'; return -3
    elsif y == 'P'; return -2
    elsif y == 'S'; return -1
    elsif y == 'T'; return -1
    elsif y == 'W'; return -3
    elsif y == 'Y'; return -2
    elsif y == 'V'; return -3
    elsif y == 'B'; return -1
    elsif y == 'Z'; return 0
    elsif y == '*'; return -4
    else; return -1
    end

  elsif x == 'N'
    if false
    elsif y == 'A'; return -2
    elsif y == 'R'; return 0
    elsif y == 'N'; return 6
    elsif y == 'D'; return 1
    elsif y == 'C'; return -3
    elsif y == 'Q'; return 0
    elsif y == 'E'; return 0
    elsif y == 'G'; return 0
    elsif y == 'H'; return 1
    elsif y == 'I'; return -3
    elsif y == 'L'; return -3
    elsif y == 'K'; return 0
    elsif y == 'M'; return -2
    elsif y == 'F'; return -3
    elsif y == 'P'; return -2
    elsif y == 'S'; return 1
    elsif y == 'T'; return 0
    elsif y == 'W'; return -4
    elsif y == 'Y'; return -2
    elsif y == 'V'; return -3
    elsif y == 'B'; return 3
    elsif y == 'Z'; return 0
    elsif y == '*'; return -4
    else; return -1
    end

  elsif x == 'D'
    if false
    elsif y == 'A'; return -2
    elsif y == 'R'; return -2
    elsif y == 'N'; return 1
    elsif y == 'D'; return 6
    elsif y == 'C'; return -3
    elsif y == 'Q'; return 0
    elsif y == 'E'; return 2
    elsif y == 'G'; return -1
    elsif y == 'H'; return -1
    elsif y == 'I'; return -3
    elsif y == 'L'; return -4
    elsif y == 'K'; return -1
    elsif y == 'M'; return -3
    elsif y == 'F'; return -3
    elsif y == 'P'; return -1
    elsif y == 'S'; return 0
    elsif y == 'T'; return -1
    elsif y == 'W'; return -4
    elsif y == 'Y'; return -3
    elsif y == 'V'; return -3
    elsif y == 'B'; return 4
    elsif y == 'Z'; return 1
    elsif y == '*'; return -4
    else; return -1
    end

  elsif x == 'C'
    if false
    elsif y == 'A'; return 0
    elsif y == 'R'; return -3
    elsif y == 'N'; return -3
    elsif y == 'D'; return -3
    elsif y == 'C'; return 9
    elsif y == 'Q'; return -3
    elsif y == 'E'; return -4
    elsif y == 'G'; return -3
    elsif y == 'H'; return -3
    elsif y == 'I'; return -1
    elsif y == 'L'; return -1
    elsif y == 'K'; return -3
    elsif y == 'M'; return -1
    elsif y == 'F'; return -2
    elsif y == 'P'; return -3
    elsif y == 'S'; return -1
    elsif y == 'T'; return -1
    elsif y == 'W'; return -2
    elsif y == 'Y'; return -2
    elsif y == 'V'; return -1
    elsif y == 'B'; return -3
    elsif y == 'Z'; return -3
    elsif y == '*'; return -4
    else; return -2
    end

  elsif x == 'Q'
    if false
    elsif y == 'A'; return -1
    elsif y == 'R'; return 1
    elsif y == 'N'; return 0
    elsif y == 'D'; return 0
    elsif y == 'C'; return -3
    elsif y == 'Q'; return 5
    elsif y == 'E'; return 2
    elsif y == 'G'; return -2
    elsif y == 'H'; return 0
    elsif y == 'I'; return -3
    elsif y == 'L'; return -2
    elsif y == 'K'; return 1
    elsif y == 'M'; return 0
    elsif y == 'F'; return -3
    elsif y == 'P'; return -1
    elsif y == 'S'; return 0
    elsif y == 'T'; return -1
    elsif y == 'W'; return -2
    elsif y == 'Y'; return -1
    elsif y == 'V'; return -2
    elsif y == 'B'; return 0
    elsif y == 'Z'; return 3
    elsif y == '*'; return -4
    else; return -1
    end

  elsif x == 'E'
    if false
    elsif y == 'A'; return -1
    elsif y == 'R'; return 0
    elsif y == 'N'; return 0
    elsif y == 'D'; return 2
    elsif y == 'C'; return -4
    elsif y == 'Q'; return 2
    elsif y == 'E'; return 5
    elsif y == 'G'; return -2
    elsif y == 'H'; return 0
    elsif y == 'I'; return -3
    elsif y == 'L'; return -3
    elsif y == 'K'; return 1
    elsif y == 'M'; return -2
    elsif y == 'F'; return -3
    elsif y == 'P'; return -1
    elsif y == 'S'; return 0
    elsif y == 'T'; return -1
    elsif y == 'W'; return -3
    elsif y == 'Y'; return -2
    elsif y == 'V'; return -2
    elsif y == 'B'; return 1
    elsif y == 'Z'; return 4
    elsif y == '*'; return -4
    else; return -1
    end

  elsif x == 'G'
    if false
    elsif y == 'A'; return 0
    elsif y == 'R'; return -2
    elsif y == 'N'; return 0
    elsif y == 'D'; return -1
    elsif y == 'C'; return -3
    elsif y == 'Q'; return -2
    elsif y == 'E'; return -2
    elsif y == 'G'; return 6
    elsif y == 'H'; return -2
    elsif y == 'I'; return -4
    elsif y == 'L'; return -4
    elsif y == 'K'; return -2
    elsif y == 'M'; return -3
    elsif y == 'F'; return -3
    elsif y == 'P'; return -2
    elsif y == 'S'; return 0
    elsif y == 'T'; return -2
    elsif y == 'W'; return -2
    elsif y == 'Y'; return -3
    elsif y == 'V'; return -3
    elsif y == 'B'; return -1
    elsif y == 'Z'; return -2
    elsif y == '*'; return -4
    else; return -1
    end

  elsif x == 'H'
    if false
    elsif y == 'A'; return -2
    elsif y == 'R'; return 0
    elsif y == 'N'; return 1
    elsif y == 'D'; return -1
    elsif y == 'C'; return -3
    elsif y == 'Q'; return 0
    elsif y == 'E'; return 0
    elsif y == 'G'; return -2
    elsif y == 'H'; return 8
    elsif y == 'I'; return -3
    elsif y == 'L'; return -3
    elsif y == 'K'; return -1
    elsif y == 'M'; return -2
    elsif y == 'F'; return -1
    elsif y == 'P'; return -2
    elsif y == 'S'; return -1
    elsif y == 'T'; return -2
    elsif y == 'W'; return -2
    elsif y == 'Y'; return 2
    elsif y == 'V'; return -3
    elsif y == 'B'; return 0
    elsif y == 'Z'; return 0
    elsif y == '*'; return -4
    else; return -1
    end

  elsif x == 'I'
    if false
    elsif y == 'A'; return -1
    elsif y == 'R'; return -3
    elsif y == 'N'; return -3
    elsif y == 'D'; return -3
    elsif y == 'C'; return -1
    elsif y == 'Q'; return -3
    elsif y == 'E'; return -3
    elsif y == 'G'; return -4
    elsif y == 'H'; return -3
    elsif y == 'I'; return 4
    elsif y == 'L'; return 2
    elsif y == 'K'; return -3
    elsif y == 'M'; return 1
    elsif y == 'F'; return 0
    elsif y == 'P'; return -3
    elsif y == 'S'; return -2
    elsif y == 'T'; return -1
    elsif y == 'W'; return -3
    elsif y == 'Y'; return -1
    elsif y == 'V'; return 3
    elsif y == 'B'; return -3
    elsif y == 'Z'; return -3
    elsif y == '*'; return -4
    else; return -1
    end

  elsif x == 'L'
    if false
    elsif y == 'A'; return -1
    elsif y == 'R'; return -2
    elsif y == 'N'; return -3
    elsif y == 'D'; return -4
    elsif y == 'C'; return -1
    elsif y == 'Q'; return -2
    elsif y == 'E'; return -3
    elsif y == 'G'; return -4
    elsif y == 'H'; return -3
    elsif y == 'I'; return 2
    elsif y == 'L'; return 4
    elsif y == 'K'; return -2
    elsif y == 'M'; return 2
    elsif y == 'F'; return 0
    elsif y == 'P'; return -3
    elsif y == 'S'; return -2
    elsif y == 'T'; return -1
    elsif y == 'W'; return -2
    elsif y == 'Y'; return -1
    elsif y == 'V'; return 1
    elsif y == 'B'; return -4
    elsif y == 'Z'; return -3
    elsif y == '*'; return -4
    else; return -1
    end

  elsif x == 'K'
    if false
    elsif y == 'A'; return -1
    elsif y == 'R'; return 2
    elsif y == 'N'; return 0
    elsif y == 'D'; return -1
    elsif y == 'C'; return -3
    elsif y == 'Q'; return 1
    elsif y == 'E'; return 1
    elsif y == 'G'; return -2
    elsif y == 'H'; return -1
    elsif y == 'I'; return -3
    elsif y == 'L'; return -2
    elsif y == 'K'; return 5
    elsif y == 'M'; return -1
    elsif y == 'F'; return -3
    elsif y == 'P'; return -1
    elsif y == 'S'; return 0
    elsif y == 'T'; return -1
    elsif y == 'W'; return -3
    elsif y == 'Y'; return -2
    elsif y == 'V'; return -2
    elsif y == 'B'; return 0
    elsif y == 'Z'; return 1
    elsif y == '*'; return -4
    else; return -1
    end

  elsif x == 'M'
    if false
    elsif y == 'A'; return -1
    elsif y == 'R'; return -1
    elsif y == 'N'; return -2
    elsif y == 'D'; return -3
    elsif y == 'C'; return -1
    elsif y == 'Q'; return 0
    elsif y == 'E'; return -2
    elsif y == 'G'; return -3
    elsif y == 'H'; return -2
    elsif y == 'I'; return 1
    elsif y == 'L'; return 2
    elsif y == 'K'; return -1
    elsif y == 'M'; return 5
    elsif y == 'F'; return 0
    elsif y == 'P'; return -2
    elsif y == 'S'; return -1
    elsif y == 'T'; return -1
    elsif y == 'W'; return -1
    elsif y == 'Y'; return -1
    elsif y == 'V'; return 1
    elsif y == 'B'; return -3
    elsif y == 'Z'; return -1
    elsif y == '*'; return -4
    else; return -1
    end

  elsif x == 'F'
    if false
    elsif y == 'A'; return -2
    elsif y == 'R'; return -3
    elsif y == 'N'; return -3
    elsif y == 'D'; return -3
    elsif y == 'C'; return -2
    elsif y == 'Q'; return -3
    elsif y == 'E'; return -3
    elsif y == 'G'; return -3
    elsif y == 'H'; return -1
    elsif y == 'I'; return 0
    elsif y == 'L'; return 0
    elsif y == 'K'; return -3
    elsif y == 'M'; return 0
    elsif y == 'F'; return 6
    elsif y == 'P'; return -4
    elsif y == 'S'; return -2
    elsif y == 'T'; return -2
    elsif y == 'W'; return 1
    elsif y == 'Y'; return 3
    elsif y == 'V'; return -1
    elsif y == 'B'; return -3
    elsif y == 'Z'; return -3
    elsif y == '*'; return -4
    else; return -1
    end

  elsif x == 'P'
    if false
    elsif y == 'A'; return -1
    elsif y == 'R'; return -2
    elsif y == 'N'; return -2
    elsif y == 'D'; return -1
    elsif y == 'C'; return -3
    elsif y == 'Q'; return -1
    elsif y == 'E'; return -1
    elsif y == 'G'; return -2
    elsif y == 'H'; return -2
    elsif y == 'I'; return -3
    elsif y == 'L'; return -3
    elsif y == 'K'; return -1
    elsif y == 'M'; return -2
    elsif y == 'F'; return -4
    elsif y == 'P'; return 7
    elsif y == 'S'; return -1
    elsif y == 'T'; return -1
    elsif y == 'W'; return -4
    elsif y == 'Y'; return -3
    elsif y == 'V'; return -2
    elsif y == 'B'; return -2
    elsif y == 'Z'; return -1
    elsif y == '*'; return -4
    else; return -2
    end

  elsif x == 'S'
    if false
    elsif y == 'A'; return 1
    elsif y == 'R'; return -1
    elsif y == 'N'; return 1
    elsif y == 'D'; return 0
    elsif y == 'C'; return -1
    elsif y == 'Q'; return 0
    elsif y == 'E'; return 0
    elsif y == 'G'; return 0
    elsif y == 'H'; return -1
    elsif y == 'I'; return -2
    elsif y == 'L'; return -2
    elsif y == 'K'; return 0
    elsif y == 'M'; return -1
    elsif y == 'F'; return -2
    elsif y == 'P'; return -1
    elsif y == 'S'; return 4
    elsif y == 'T'; return 1
    elsif y == 'W'; return -3
    elsif y == 'Y'; return -2
    elsif y == 'V'; return -2
    elsif y == 'B'; return 0
    elsif y == 'Z'; return 0
    elsif y == '*'; return -4
    else; return 0
    end

  elsif x == 'T'
    if false
    elsif y == 'A'; return 0
    elsif y == 'R'; return -1
    elsif y == 'N'; return 0
    elsif y == 'D'; return -1
    elsif y == 'C'; return -1
    elsif y == 'Q'; return -1
    elsif y == 'E'; return -1
    elsif y == 'G'; return -2
    elsif y == 'H'; return -2
    elsif y == 'I'; return -1
    elsif y == 'L'; return -1
    elsif y == 'K'; return -1
    elsif y == 'M'; return -1
    elsif y == 'F'; return -2
    elsif y == 'P'; return -1
    elsif y == 'S'; return 1
    elsif y == 'T'; return 5
    elsif y == 'W'; return -2
    elsif y == 'Y'; return -2
    elsif y == 'V'; return 0
    elsif y == 'B'; return -1
    elsif y == 'Z'; return -1
    elsif y == '*'; return -4
    else; return 0
    end

  elsif x == 'W'
    if false
    elsif y == 'A'; return -3
    elsif y == 'R'; return -3
    elsif y == 'N'; return -4
    elsif y == 'D'; return -4
    elsif y == 'C'; return -2
    elsif y == 'Q'; return -2
    elsif y == 'E'; return -3
    elsif y == 'G'; return -2
    elsif y == 'H'; return -2
    elsif y == 'I'; return -3
    elsif y == 'L'; return -2
    elsif y == 'K'; return -3
    elsif y == 'M'; return -1
    elsif y == 'F'; return 1
    elsif y == 'P'; return -4
    elsif y == 'S'; return -3
    elsif y == 'T'; return -2
    elsif y == 'W'; return 11
    elsif y == 'Y'; return 2
    elsif y == 'V'; return -3
    elsif y == 'B'; return -4
    elsif y == 'Z'; return -3
    elsif y == '*'; return -4
    else; return -2
    end

  elsif x == 'Y'
    if false
    elsif y == 'A'; return -2
    elsif y == 'R'; return -2
    elsif y == 'N'; return -2
    elsif y == 'D'; return -3
    elsif y == 'C'; return -2
    elsif y == 'Q'; return -1
    elsif y == 'E'; return -2
    elsif y == 'G'; return -3
    elsif y == 'H'; return 2
    elsif y == 'I'; return -1
    elsif y == 'L'; return -1
    elsif y == 'K'; return -2
    elsif y == 'M'; return -1
    elsif y == 'F'; return 3
    elsif y == 'P'; return -3
    elsif y == 'S'; return -2
    elsif y == 'T'; return -2
    elsif y == 'W'; return 2
    elsif y == 'Y'; return 7
    elsif y == 'V'; return -1
    elsif y == 'B'; return -3
    elsif y == 'Z'; return -2
    elsif y == '*'; return -4
    else; return -1
    end

  elsif x == 'V'
    if false
    elsif y == 'A'; return 0
    elsif y == 'R'; return -3
    elsif y == 'N'; return -3
    elsif y == 'D'; return -3
    elsif y == 'C'; return -1
    elsif y == 'Q'; return -2
    elsif y == 'E'; return -2
    elsif y == 'G'; return -3
    elsif y == 'H'; return -3
    elsif y == 'I'; return 3
    elsif y == 'L'; return 1
    elsif y == 'K'; return -2
    elsif y == 'M'; return 1
    elsif y == 'F'; return -1
    elsif y == 'P'; return -2
    elsif y == 'S'; return -2
    elsif y == 'T'; return 0
    elsif y == 'W'; return -3
    elsif y == 'Y'; return -1
    elsif y == 'V'; return 4
    elsif y == 'B'; return -3
    elsif y == 'Z'; return -2
    elsif y == '*'; return -4
    else; return -1
    end

  elsif x == 'B'
    if false
    elsif y == 'A'; return -2
    elsif y == 'R'; return -1
    elsif y == 'N'; return 3
    elsif y == 'D'; return 4
    elsif y == 'C'; return -3
    elsif y == 'Q'; return 0
    elsif y == 'E'; return 1
    elsif y == 'G'; return -1
    elsif y == 'H'; return 0
    elsif y == 'I'; return -3
    elsif y == 'L'; return -4
    elsif y == 'K'; return 0
    elsif y == 'M'; return -3
    elsif y == 'F'; return -3
    elsif y == 'P'; return -2
    elsif y == 'S'; return 0
    elsif y == 'T'; return -1
    elsif y == 'W'; return -4
    elsif y == 'Y'; return -3
    elsif y == 'V'; return -3
    elsif y == 'B'; return 4
    elsif y == 'Z'; return 1
    elsif y == '*'; return -4
    else; return -1
    end

  elsif x == 'Z'
    if false
    elsif y == 'A'; return -1
    elsif y == 'R'; return 0
    elsif y == 'N'; return 0
    elsif y == 'D'; return 1
    elsif y == 'C'; return -3
    elsif y == 'Q'; return 3
    elsif y == 'E'; return 4
    elsif y == 'G'; return -2
    elsif y == 'H'; return 0
    elsif y == 'I'; return -3
    elsif y == 'L'; return -3
    elsif y == 'K'; return 1
    elsif y == 'M'; return -1
    elsif y == 'F'; return -3
    elsif y == 'P'; return -1
    elsif y == 'S'; return 0
    elsif y == 'T'; return -1
    elsif y == 'W'; return -3
    elsif y == 'Y'; return -2
    elsif y == 'V'; return -2
    elsif y == 'B'; return 1
    elsif y == 'Z'; return 4
    elsif y == '*'; return -4
    else; return -1
    end

  elsif x == '*'
    if false
    elsif y == 'A'; return -4
    elsif y == 'R'; return -4
    elsif y == 'N'; return -4
    elsif y == 'D'; return -4
    elsif y == 'C'; return -4
    elsif y == 'Q'; return -4
    elsif y == 'E'; return -4
    elsif y == 'G'; return -4
    elsif y == 'H'; return -4
    elsif y == 'I'; return -4
    elsif y == 'L'; return -4
    elsif y == 'K'; return -4
    elsif y == 'M'; return -4
    elsif y == 'F'; return -4
    elsif y == 'P'; return -4
    elsif y == 'S'; return -4
    elsif y == 'T'; return -4
    elsif y == 'W'; return -4
    elsif y == 'Y'; return -4
    elsif y == 'V'; return -4
    elsif y == 'B'; return -4
    elsif y == 'Z'; return -4
    elsif y == '*'; return 1
    else; return -4
    end

  else
    case y
    when 'A'; return 0
    when 'R'; return -1
    when 'N'; return -1
    when 'D'; return -1
    when 'C'; return -2
    when 'Q'; return -1
    when 'E'; return -1
    when 'G'; return -1
    when 'H'; return -1
    when 'I'; return -1
    when 'L'; return -1
    when 'K'; return -1
    when 'M'; return -1
    when 'F'; return -1
    when 'P'; return -2
    when 'S'; return 0
    when 'T'; return 0
    when 'W'; return -2
    when 'Y'; return -1
    when 'V'; return -1
    when 'B'; return -1
    when 'Z'; return -1
    when '*'; return -4
    else; return -1
    end

  end
end
