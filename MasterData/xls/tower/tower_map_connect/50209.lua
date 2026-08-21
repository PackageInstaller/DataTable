local empty = {}
return
{
  Row = 3,
  Column = 3,
  MapID = 50209,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 4 ] = {
      WindowPos = { 0.0, 0.0833333358 },
      RoomNum = 4,
      uuid = 0,
      StartDir = 0,
      EndDir = 3,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 1,
      LogicNum = 502092,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 5,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 5 ] = {
      WindowPos = { 0.046875, 0.0833333358 },
      RoomNum = 5,
      uuid = 0,
      StartDir = 4,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 2,
      LogicNum = 502091,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 4,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}