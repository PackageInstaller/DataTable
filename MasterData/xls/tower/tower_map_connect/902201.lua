local empty = {}
return
{
  Row = 3,
  Column = 3,
  MapID = 902201,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 1 ] = {
      WindowPos = { 0.0, 0.0 },
      RoomNum = 1,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 0,
      RowNum = 1,
      ColumnNum = 1,
      LogicNum = 90214,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
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
      LogicNum = 90205,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 3,
          IsLocked = false,
          UnlockCondition = {
            100032
          },
          UnlockDesc = ""
        },
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 1,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 5,
          IsLocked = false,
          UnlockCondition = {
            100032
          },
          UnlockDesc = ""
        }
      }
    },
    [ 3 ] = {
      WindowPos = { 0.09375, 0.0 },
      RoomNum = 3,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 1,
      ColumnNum = 3,
      LogicNum = 90210,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 2,
          IsLocked = false,
          UnlockCondition = {
            100032
          },
          UnlockDesc = ""
        },
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 4,
          TargetRoomNum = 5,
          IsLocked = true,
          UnlockCondition = {
            100032
          },
          UnlockDesc = ""
        }
      }
    },
    [ 4 ] = {
      WindowPos = { 0.0, 0.0833333358 },
      RoomNum = 4,
      uuid = 0,
      StartDir = 0,
      EndDir = 2,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 1,
      LogicNum = 902042,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 5,
          IsLocked = true,
          UnlockCondition = {
            100031
          },
          UnlockDesc = ""
        }
      }
    },
    [ 5 ] = {
      WindowPos = { 0.046875, 0.0833333358 },
      RoomNum = 5,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 2,
      LogicNum = 90204,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 4,
          IsLocked = true,
          UnlockCondition = {
            100031
          },
          UnlockDesc = ""
        },
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 3,
          TargetRoomNum = 3,
          IsLocked = true,
          UnlockCondition = {
            100032
          },
          UnlockDesc = ""
        },
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 2,
          IsLocked = false,
          UnlockCondition = {
            100032
          },
          UnlockDesc = ""
        },
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 8,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 8 ] = {
      WindowPos = { 0.046875, 0.166666672 },
      RoomNum = 8,
      uuid = 0,
      StartDir = 3,
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 2,
      LogicNum = 902041,
      RoomConnectDic = {
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 5,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}