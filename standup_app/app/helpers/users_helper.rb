module UsersHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def generate_csv(users)
    column_names = [
      "ID","NAME", "Start At", "End At", "Work Log"
    ]
    CSV.generate(force_quotes: true) do |csv|
      csv << column_names
      users.each do |m|
        if m.start_at.strftime("%m/%d/%Y") && m.end_at.strftime("%m/%d/%Y") == Date.today.strftime("%m/%d/%Y")
          time_diff = m.end_at - m.start_at
          work_log = Time.at(time_diff.round.abs).utc.strftime "%H:%M:%S"
        elsif m.start_at.strftime("%m/%d/%Y") && m.end_at.strftime("%m/%d/%Y") == Date.yesterday.strftime("%m/%d/%Y")
          time_diff = m.end_at - m.start_at
          work_log = Time.at(time_diff.round.abs).utc.strftime "%H:%M:%S"
        end

        row = [
          m.id, m.name, m.start_at, m.end_at, work_log
        ]
        csv << row
      end
    end
  end
end
