class Character < Granite::Base
  connection pg
  table characters

  column id : Int64, primary: true
  column name : String?
  column name_japanese : String?
  column birthday : String?
  column bounty : Int64?
  column nickname : String?
  column description : String?
  timestamps
end
