local empty = {}
return
{
  Row = 3,
  Column = 6,
  MapID = 1019,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 4 ] = {
      WindowPos = { 0.140625, 0.0 },
      RoomNum = 4,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 1,
      ColumnNum = 4,
      LogicNum = 101202,
      RoomConnectDic = empty,
    },
    [ 5 ] = {
      WindowPos = { 0.1875, 0.0 },
      RoomNum = 5,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 1,
      ColumnNum = 5,
      LogicNum = 101201,
      RoomConnectDic = empty,
    },
    [ 9 ] = {
      WindowPos = { 0.09375, 0.0833333358 },
      RoomNum = 9,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 3,
      LogicNum = 101205,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 10,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 10 ] = {
      WindowPos = { 0.140625, 0.0833333358 },
      RoomNum = 10,
      uuid = 0,
      StartDir = 1,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 4,
      LogicNum = 101222,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 16,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 9,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 11 ] = {
      WindowPos = { 0.1875, 0.0833333358 },
      RoomNum = 11,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 5,
      LogicNum = 101203,
      RoomConnectDic = empty,
    },
    [ 14 ] = {
      WindowPos = { 0.046875, 0.166666672 },
      RoomNum = 14,
      uuid = 0,
      StartDir = 0,
      EndDir = 2,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 2,
      LogicNum = 101208,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 15,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 15 ] = {
      WindowPos = { 0.09375, 0.166666672 },
      RoomNum = 15,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 3,
      LogicNum = 101207,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 16,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 14,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 16 ] = {
      WindowPos = { 0.140625, 0.166666672 },
      RoomNum = 16,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 4,
      LogicNum = 101206,
      RoomConnectDic = {
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 10,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 15,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}