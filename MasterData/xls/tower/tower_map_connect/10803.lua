local empty = {}
return
{
  Row = 5,
  Column = 5,
  MapID = 10803,
  RoomCount = 0,
  Desc = "第八章-第3层",
  RoomDic = {
    [ 7 ] = {
      WindowPos = { 0.046875, 0.0833333358 },
      RoomNum = 7,
      uuid = 0,
      StartDir = 1,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 2,
      LogicNum = 1080301,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 1,
          TargetRoomNum = 13,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 13 ] = {
      WindowPos = { 0.09375, 0.166666672 },
      RoomNum = 13,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 3,
      LogicNum = 1080303,
      RoomConnectDic = {
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 4,
          TargetRoomNum = 7,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 1,
          TargetRoomNum = 19,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 19 ] = {
      WindowPos = { 0.140625, 0.25 },
      RoomNum = 19,
      uuid = 0,
      StartDir = 0,
      EndDir = 4,
      RoomType = 1,
      RowNum = 4,
      ColumnNum = 4,
      LogicNum = 1080302,
      RoomConnectDic = {
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 4,
          TargetRoomNum = 13,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}