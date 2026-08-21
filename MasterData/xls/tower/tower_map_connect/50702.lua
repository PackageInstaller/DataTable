local empty = {}
return
{
  Row = 2,
  Column = 2,
  MapID = 50702,
  RoomCount = 0,
  Desc = "困难7-2",
  RoomDic = {
    [ 2 ] = {
      WindowPos = { 0.046875, 0.0 },
      RoomNum = 2,
      uuid = 0,
      StartDir = 0,
      EndDir = 4,
      RoomType = 1,
      RowNum = 1,
      ColumnNum = 2,
      LogicNum = 507022,
      RoomConnectDic = {
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 4,
          TargetRoomNum = 3,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 3 ] = {
      WindowPos = { 0.0, 0.0833333358 },
      RoomNum = 3,
      uuid = 0,
      StartDir = 1,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 1,
      LogicNum = 507021,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 1,
          TargetRoomNum = 2,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}