local empty = {}
return
{
  Row = 0,
  Column = 0,
  MapID = 2048,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 1 ] = {
      WindowPos = { 0.0, 0.0 },
      RoomNum = 1,
      uuid = 0,
      StartDir = 0,
      EndDir = 1,
      RoomType = 16,
      RowNum = 0,
      ColumnNum = 0,
      LogicNum = 0,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 2,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 2 ] = {
      WindowPos = { 0.0, 0.0833333358 },
      RoomNum = 2,
      uuid = 0,
      StartDir = 3,
      EndDir = 3,
      RoomType = 12,
      RowNum = 0,
      ColumnNum = 0,
      LogicNum = 0,
      RoomConnectDic = {
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 1,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}