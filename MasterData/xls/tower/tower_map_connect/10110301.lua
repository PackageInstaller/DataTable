local empty = {}
return
{
  Row = 0,
  Column = 0,
  MapID = 10110301,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 1 ] = {
      WindowPos = { 0.0, 0.0 },
      RoomNum = 1,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 1,
      ColumnNum = 1,
      LogicNum = 1001020101,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 4,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
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
      EndDir = 4,
      RoomType = 1,
      RowNum = 1,
      ColumnNum = 2,
      LogicNum = 1001020101,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 1,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 4 ] = {
      WindowPos = { 0.0, 0.0833333358 },
      RoomNum = 4,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 1,
      LogicNum = 1001020101,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 7,
          IsLocked = true,
          UnlockCondition = {
            100032
          },
          UnlockDesc = ""
        },
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 5,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 1,
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
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 2,
      LogicNum = 1001020101,
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
          TargetRoomNum = 11,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 6,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 6 ] = {
      WindowPos = { 0.09375, 0.0833333358 },
      RoomNum = 6,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 2,
      ColumnNum = 3,
      LogicNum = 1001020102,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 5,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 7 ] = {
      WindowPos = { 0.0, 0.166666672 },
      RoomNum = 7,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 1,
      LogicNum = 1001020103,
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
          TargetRoomNum = 4,
          IsLocked = true,
          UnlockCondition = {
            100032
          },
          UnlockDesc = ""
        }
      }
    },
    [ 10 ] = {
      WindowPos = { 0.0, 0.25 },
      RoomNum = 10,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 4,
      ColumnNum = 1,
      LogicNum = 1001020101,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 13,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 7,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 11 ] = {
      WindowPos = { 0.046875, 0.25 },
      RoomNum = 11,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 4,
      ColumnNum = 2,
      LogicNum = 1001020101,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 14,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 5,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 13 ] = {
      WindowPos = { 0.0, 0.333333343 },
      RoomNum = 13,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 5,
      ColumnNum = 1,
      LogicNum = 1001020101,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 14,
          IsLocked = true,
          UnlockCondition = {
            100031
          },
          UnlockDesc = ""
        },
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 10,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 14 ] = {
      WindowPos = { 0.046875, 0.333333343 },
      RoomNum = 14,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 5,
      ColumnNum = 2,
      LogicNum = 1001020101,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 17,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
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
          TargetRoomNum = 11,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 17 ] = {
      WindowPos = { 0.046875, 0.416666657 },
      RoomNum = 17,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 6,
      ColumnNum = 2,
      LogicNum = 1001020101,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 18,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 14,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 18 ] = {
      WindowPos = { 0.09375, 0.416666657 },
      RoomNum = 18,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 6,
      ColumnNum = 3,
      LogicNum = 1001020101,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 21,
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
    },
    [ 20 ] = {
      WindowPos = { 0.046875, 0.5 },
      RoomNum = 20,
      uuid = 0,
      StartDir = 2,
      EndDir = 0,
      RoomType = 1,
      RowNum = 7,
      ColumnNum = 2,
      LogicNum = 1001020101,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 21,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 21 ] = {
      WindowPos = { 0.09375, 0.5 },
      RoomNum = 21,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 7,
      ColumnNum = 3,
      LogicNum = 1001020101,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 20,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 18,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}