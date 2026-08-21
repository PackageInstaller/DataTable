local empty = {}
return
{
  Row = 5,
  Column = 5,
  MapID = 67001,
  RoomCount = 0,
  Desc = "新章节Demo测试-第九章",
  RoomDic = {
    [ 13 ] = {
      WindowPos = { 0.09375, 0.166666672 },
      RoomNum = 13,
      uuid = 0,
      StartDir = 0,
      EndDir = 1,
      RoomType = 1,
      RowNum = 3,
      ColumnNum = 3,
      LogicNum = 6700102,
      RoomConnectDic = {
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 18,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 18 ] = {
      WindowPos = { 0.09375, 0.25 },
      RoomNum = 18,
      uuid = 0,
      StartDir = 3,
      EndDir = 0,
      RoomType = 1,
      RowNum = 4,
      ColumnNum = 3,
      LogicNum = 6700101,
      RoomConnectDic = {
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 13,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}