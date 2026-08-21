local empty = {}
return
{
  Row = 2,
  Column = 2,
  MapID = 50703,
  RoomCount = 0,
  Desc = "困难7-3",
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
      LogicNum = 507032,
      RoomConnectDic = {
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 4,
          TargetRoomNum = 4,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 4 ] = {
      WindowPos = { 0.046875, 0.0833333358 },
      RoomNum = 4,
      uuid = 0,
      StartDir = 1,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 2,
      LogicNum = 507031,
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