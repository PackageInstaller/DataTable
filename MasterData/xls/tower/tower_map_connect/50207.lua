local empty = {}
return
{
  Row = 4,
  Column = 4,
  MapID = 50207,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 7 ] = {
      WindowPos = { 0.09375, 0.0833333358 },
      RoomNum = 7,
      uuid = 0,
      StartDir = 0,
      EndDir = 1,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 3,
      LogicNum = 502072,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 11,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 11 ] = {
      WindowPos = { 0.09375, 0.166666672 },
      RoomNum = 11,
      uuid = 0,
      StartDir = 2,
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 3,
      LogicNum = 502071,
      RoomConnectDic = {
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 7,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}