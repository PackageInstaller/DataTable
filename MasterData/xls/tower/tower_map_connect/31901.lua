local empty = {}
return
{
  Row = 5,
  Column = 5,
  MapID = 31901,
  RoomCount = 0,
  Desc = "阿紫番外F1",
  RoomDic = {
    [ 7 ] = {
      WindowPos = { 0.046875, 0.0833333358 },
      RoomNum = 7,
      uuid = 0,
      StartDir = 2,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 2,
      LogicNum = 3190101,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 8,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 8 ] = {
      WindowPos = { 0.09375, 0.0833333358 },
      RoomNum = 8,
      uuid = 0,
      StartDir = 0,
      EndDir = 4,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 3,
      LogicNum = 3190102,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 7,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}