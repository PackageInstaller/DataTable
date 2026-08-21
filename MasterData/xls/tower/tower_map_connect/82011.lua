local empty = {}
return
{
  Row = 5,
  Column = 2,
  MapID = 82011,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 2 ] = {
      WindowPos = { 0.046875, 0.0 },
      RoomNum = 2,
      uuid = 0,
      StartDir = 0,
      EndDir = 1,
      RoomType = 0,
      RowNum = 1,
      ColumnNum = 2,
      LogicNum = 820114,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
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
      EndDir = 0,
      RoomType = 0,
      RowNum = 2,
      ColumnNum = 2,
      LogicNum = 820113,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 6,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 2,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 6 ] = {
      WindowPos = { 0.046875, 0.166666672 },
      RoomNum = 6,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 13,
      RowNum = 3,
      ColumnNum = 2,
      LogicNum = 820112,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 8,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 4,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 8 ] = {
      WindowPos = { 0.046875, 0.25 },
      RoomNum = 8,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 15,
      RowNum = 4,
      ColumnNum = 2,
      LogicNum = 820111,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 10,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 6,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 10 ] = {
      WindowPos = { 0.046875, 0.333333343 },
      RoomNum = 10,
      uuid = 0,
      StartDir = 3,
      EndDir = 0,
      RoomType = 14,
      RowNum = 5,
      ColumnNum = 2,
      LogicNum = 0,
      RoomConnectDic = {
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 8,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}