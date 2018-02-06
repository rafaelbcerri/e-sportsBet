module DateHelper
  def user_age(birthday)
    age = Date.today.year - birthday.year
    age -= 1 if Date.today < birthday + age.years
    age
  end

  def brazilian_date(date)
    date.strftime("%d/%m/%Y")
  end
end
