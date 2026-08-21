local empty = {}
return
{
  Row = 2,
  Column = 2,
  MapID = 32101,
  RoomCount = 0,
  Desc = "番外-南娜个人故事1",
  RoomDic = {
    [ 1 ] = {
      WindowPos = { 0.0, 0.0 },
      RoomNum = 1,
      uuid = 0,
      StartDir = 1,
      EndDir = 1,
      RoomType = 1,
      RowNum = 1,
      ColumnNum = 1,
      LogicNum = 3210101,
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
    },
    [ 2 ] = {
      WindowPos = { 0.046875, 0.0 },
      RoomNum = 2,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 1,
      ColumnNum = 2,
      LogicNum = 3210102,
      RoomConnectDic = {
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 4,
          TargetRoomNum = 1,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 1,
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
      StartDir = 0,
      EndDir = 4,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 2,
      LogicNum = 3210103,
      RoomConnectDic = {
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 4,
          TargetRoomNum = 2,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}