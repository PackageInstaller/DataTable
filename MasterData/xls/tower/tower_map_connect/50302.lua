local empty = {}
return
{
  Row = 3,
  Column = 3,
  MapID = 50302,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 6 ] = {
      WindowPos = { 0.09375, 0.0833333358 },
      RoomNum = 6,
      uuid = 0,
      StartDir = 0,
      EndDir = 1,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 3,
      LogicNum = 503022,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 4,
          TargetRoomNum = 9,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 9 ] = {
      WindowPos = { 0.09375, 0.166666672 },
      RoomNum = 9,
      uuid = 0,
      StartDir = 3,
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 3,
      LogicNum = 503021,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 3,
          TargetRoomNum = 6,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}