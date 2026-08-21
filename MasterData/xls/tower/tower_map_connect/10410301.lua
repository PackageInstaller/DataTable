local empty = {}
return
{
  Row = 0,
  Column = 0,
  MapID = 10410301,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 1 ] = {
      WindowPos = { 0.0, 0.0 },
      RoomNum = 1,
      uuid = 0,
      StartDir = 1,
      EndDir = 0,
      RoomType = 1,
      RowNum = 1,
      ColumnNum = 1,
      LogicNum = 1031010101,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
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
      StartDir = 0,
      EndDir = 3,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 1,
      LogicNum = 1031010102,
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