local empty = {}
return
{
  Row = 0,
  Column = 0,
  MapID = 33333333,
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
      LogicNum = 307,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 11,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
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
      WindowPos = { 0.1875, 0.0 },
      RoomNum = 5,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 1,
      ColumnNum = 5,
      LogicNum = 310,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 4,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 19,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 8 ] = {
      WindowPos = { 0.0, 0.0833333358 },
      RoomNum = 8,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 1,
      LogicNum = 302,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 9,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 15,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 9 ] = {
      WindowPos = { 0.046875, 0.0833333358 },
      RoomNum = 9,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 2,
      LogicNum = 303,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 8,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
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
      WindowPos = { 0.09375, 0.0833333358 },
      RoomNum = 10,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 3,
      LogicNum = 304,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 9,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 17,
          IsLocked = true,
          UnlockCondition = {
            100032
          },
          UnlockDesc = ""
        },
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 11,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 11 ] = {
      WindowPos = { 0.140625, 0.0833333358 },
      RoomNum = 11,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 4,
      LogicNum = 305,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 10,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 13,
          IsLocked = true,
          UnlockCondition = {
            100031
          },
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
    [ 13 ] = {
      WindowPos = { 0.234375, 0.0833333358 },
      RoomNum = 13,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 6,
      LogicNum = 311,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 11,
          IsLocked = true,
          UnlockCondition = {
            100031
          },
          UnlockDesc = ""
        },
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 14,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 14 ] = {
      WindowPos = { 0.28125, 0.0833333358 },
      RoomNum = 14,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 7,
      LogicNum = 308,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 13,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 15 ] = {
      WindowPos = { 0.0, 0.166666672 },
      RoomNum = 15,
      uuid = 0,
      StartDir = 3,
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 1,
      LogicNum = 301,
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
    },
    [ 17 ] = {
      WindowPos = { 0.09375, 0.166666672 },
      RoomNum = 17,
      uuid = 0,
      StartDir = 0,
      EndDir = 3,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 3,
      LogicNum = 306,
      RoomConnectDic = {
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 10,
          IsLocked = true,
          UnlockCondition = {
            100032
          },
          UnlockDesc = ""
        },
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 19,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 19 ] = {
      WindowPos = { 0.1875, 0.166666672 },
      RoomNum = 19,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 5,
      LogicNum = 309,
      RoomConnectDic = {
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 5,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 17,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}