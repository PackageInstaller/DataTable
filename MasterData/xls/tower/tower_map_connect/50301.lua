local empty = {}
return
{
  Row = 3,
  Column = 3,
  MapID = 50301,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 8 ] = {
      WindowPos = { 0.046875, 0.166666672 },
      RoomNum = 8,
      uuid = 0,
      StartDir = 0,
      EndDir = 2,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 2,
      LogicNum = 503012,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
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
      LogicNum = 503011,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 8,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}