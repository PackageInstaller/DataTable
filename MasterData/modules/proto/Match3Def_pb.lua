-- chunkname: @modules/proto/Match3Def_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Match3Def_pb", package.seeall)

local Match3Def_pb = {}

Match3Def_pb.MATCH3CHESSBOARD_MSG = protobuf.Descriptor()
Match3Def_pb.MATCH3CHESSBOARDROWFIELD = protobuf.FieldDescriptor()
Match3Def_pb.CHESS_MSG = protobuf.Descriptor()
Match3Def_pb.CHESSTYPEFIELD = protobuf.FieldDescriptor()
Match3Def_pb.CHESSIDFIELD = protobuf.FieldDescriptor()
Match3Def_pb.CHESSCOORDINATEFIELD = protobuf.FieldDescriptor()
Match3Def_pb.TIDYUPCOL_MSG = protobuf.Descriptor()
Match3Def_pb.TIDYUPCOLCOLFIELD = protobuf.FieldDescriptor()
Match3Def_pb.TIDYUPCOLOLDXFIELD = protobuf.FieldDescriptor()
Match3Def_pb.TIDYUPCOLNEWXFIELD = protobuf.FieldDescriptor()
Match3Def_pb.MATCH3TIPS_MSG = protobuf.Descriptor()
Match3Def_pb.MATCH3TIPSFROMFIELD = protobuf.FieldDescriptor()
Match3Def_pb.MATCH3TIPSTOFIELD = protobuf.FieldDescriptor()
Match3Def_pb.MATCH3TIPSELIMINATEFIELD = protobuf.FieldDescriptor()
Match3Def_pb.COORDINATE_MSG = protobuf.Descriptor()
Match3Def_pb.COORDINATEXFIELD = protobuf.FieldDescriptor()
Match3Def_pb.COORDINATEYFIELD = protobuf.FieldDescriptor()
Match3Def_pb.FILLCHESSBOARD_MSG = protobuf.Descriptor()
Match3Def_pb.FILLCHESSBOARDDIRFIELD = protobuf.FieldDescriptor()
Match3Def_pb.FILLCHESSBOARDCHESSFIELD = protobuf.FieldDescriptor()
Match3Def_pb.ELIMINATE_MSG = protobuf.Descriptor()
Match3Def_pb.ELIMINATECOORDINATEFIELD = protobuf.FieldDescriptor()
Match3Def_pb.ELIMINATEEXTRADATAFIELD = protobuf.FieldDescriptor()
Match3Def_pb.ELIMINATETYPEFIELD = protobuf.FieldDescriptor()
Match3Def_pb.ELIMINATESOURCEFIELD = protobuf.FieldDescriptor()
Match3Def_pb.TIDYUP_MSG = protobuf.Descriptor()
Match3Def_pb.TIDYUPCOLFIELD = protobuf.FieldDescriptor()
Match3Def_pb.TIDYUPROWFIELD = protobuf.FieldDescriptor()
Match3Def_pb.CHESSBOARDROW_MSG = protobuf.Descriptor()
Match3Def_pb.CHESSBOARDROWCHESSFIELD = protobuf.FieldDescriptor()
Match3Def_pb.TIDYUPROW_MSG = protobuf.Descriptor()
Match3Def_pb.TIDYUPROWROWFIELD = protobuf.FieldDescriptor()
Match3Def_pb.TIDYUPROWOLDYFIELD = protobuf.FieldDescriptor()
Match3Def_pb.TIDYUPROWNEWYFIELD = protobuf.FieldDescriptor()
Match3Def_pb.MATCH3TURN_MSG = protobuf.Descriptor()
Match3Def_pb.MATCH3TURNELIMINATEFIELD = protobuf.FieldDescriptor()
Match3Def_pb.MATCH3TURNTIDYUPFIELD = protobuf.FieldDescriptor()
Match3Def_pb.MATCH3TURNFILLCHESSBOARDFIELD = protobuf.FieldDescriptor()
Match3Def_pb.MATCH3CHESSBOARDROWFIELD.name = "row"
Match3Def_pb.MATCH3CHESSBOARDROWFIELD.full_name = ".Match3ChessBoard.row"
Match3Def_pb.MATCH3CHESSBOARDROWFIELD.number = 1
Match3Def_pb.MATCH3CHESSBOARDROWFIELD.index = 0
Match3Def_pb.MATCH3CHESSBOARDROWFIELD.label = 3
Match3Def_pb.MATCH3CHESSBOARDROWFIELD.has_default_value = false
Match3Def_pb.MATCH3CHESSBOARDROWFIELD.default_value = {}
Match3Def_pb.MATCH3CHESSBOARDROWFIELD.message_type = Match3Def_pb.CHESSBOARDROW_MSG
Match3Def_pb.MATCH3CHESSBOARDROWFIELD.type = 11
Match3Def_pb.MATCH3CHESSBOARDROWFIELD.cpp_type = 10
Match3Def_pb.MATCH3CHESSBOARD_MSG.name = "Match3ChessBoard"
Match3Def_pb.MATCH3CHESSBOARD_MSG.full_name = ".Match3ChessBoard"
Match3Def_pb.MATCH3CHESSBOARD_MSG.nested_types = {}
Match3Def_pb.MATCH3CHESSBOARD_MSG.enum_types = {}
Match3Def_pb.MATCH3CHESSBOARD_MSG.fields = {
	Match3Def_pb.MATCH3CHESSBOARDROWFIELD
}
Match3Def_pb.MATCH3CHESSBOARD_MSG.is_extendable = false
Match3Def_pb.MATCH3CHESSBOARD_MSG.extensions = {}
Match3Def_pb.CHESSTYPEFIELD.name = "type"
Match3Def_pb.CHESSTYPEFIELD.full_name = ".Chess.type"
Match3Def_pb.CHESSTYPEFIELD.number = 1
Match3Def_pb.CHESSTYPEFIELD.index = 0
Match3Def_pb.CHESSTYPEFIELD.label = 1
Match3Def_pb.CHESSTYPEFIELD.has_default_value = false
Match3Def_pb.CHESSTYPEFIELD.default_value = 0
Match3Def_pb.CHESSTYPEFIELD.type = 5
Match3Def_pb.CHESSTYPEFIELD.cpp_type = 1
Match3Def_pb.CHESSIDFIELD.name = "id"
Match3Def_pb.CHESSIDFIELD.full_name = ".Chess.id"
Match3Def_pb.CHESSIDFIELD.number = 2
Match3Def_pb.CHESSIDFIELD.index = 1
Match3Def_pb.CHESSIDFIELD.label = 1
Match3Def_pb.CHESSIDFIELD.has_default_value = false
Match3Def_pb.CHESSIDFIELD.default_value = 0
Match3Def_pb.CHESSIDFIELD.type = 5
Match3Def_pb.CHESSIDFIELD.cpp_type = 1
Match3Def_pb.CHESSCOORDINATEFIELD.name = "coordinate"
Match3Def_pb.CHESSCOORDINATEFIELD.full_name = ".Chess.coordinate"
Match3Def_pb.CHESSCOORDINATEFIELD.number = 3
Match3Def_pb.CHESSCOORDINATEFIELD.index = 2
Match3Def_pb.CHESSCOORDINATEFIELD.label = 1
Match3Def_pb.CHESSCOORDINATEFIELD.has_default_value = false
Match3Def_pb.CHESSCOORDINATEFIELD.default_value = nil
Match3Def_pb.CHESSCOORDINATEFIELD.message_type = Match3Def_pb.COORDINATE_MSG
Match3Def_pb.CHESSCOORDINATEFIELD.type = 11
Match3Def_pb.CHESSCOORDINATEFIELD.cpp_type = 10
Match3Def_pb.CHESS_MSG.name = "Chess"
Match3Def_pb.CHESS_MSG.full_name = ".Chess"
Match3Def_pb.CHESS_MSG.nested_types = {}
Match3Def_pb.CHESS_MSG.enum_types = {}
Match3Def_pb.CHESS_MSG.fields = {
	Match3Def_pb.CHESSTYPEFIELD,
	Match3Def_pb.CHESSIDFIELD,
	Match3Def_pb.CHESSCOORDINATEFIELD
}
Match3Def_pb.CHESS_MSG.is_extendable = false
Match3Def_pb.CHESS_MSG.extensions = {}
Match3Def_pb.TIDYUPCOLCOLFIELD.name = "col"
Match3Def_pb.TIDYUPCOLCOLFIELD.full_name = ".TidyUpCol.col"
Match3Def_pb.TIDYUPCOLCOLFIELD.number = 1
Match3Def_pb.TIDYUPCOLCOLFIELD.index = 0
Match3Def_pb.TIDYUPCOLCOLFIELD.label = 1
Match3Def_pb.TIDYUPCOLCOLFIELD.has_default_value = false
Match3Def_pb.TIDYUPCOLCOLFIELD.default_value = 0
Match3Def_pb.TIDYUPCOLCOLFIELD.type = 5
Match3Def_pb.TIDYUPCOLCOLFIELD.cpp_type = 1
Match3Def_pb.TIDYUPCOLOLDXFIELD.name = "oldX"
Match3Def_pb.TIDYUPCOLOLDXFIELD.full_name = ".TidyUpCol.oldX"
Match3Def_pb.TIDYUPCOLOLDXFIELD.number = 2
Match3Def_pb.TIDYUPCOLOLDXFIELD.index = 1
Match3Def_pb.TIDYUPCOLOLDXFIELD.label = 3
Match3Def_pb.TIDYUPCOLOLDXFIELD.has_default_value = false
Match3Def_pb.TIDYUPCOLOLDXFIELD.default_value = {}
Match3Def_pb.TIDYUPCOLOLDXFIELD.type = 5
Match3Def_pb.TIDYUPCOLOLDXFIELD.cpp_type = 1
Match3Def_pb.TIDYUPCOLNEWXFIELD.name = "newX"
Match3Def_pb.TIDYUPCOLNEWXFIELD.full_name = ".TidyUpCol.newX"
Match3Def_pb.TIDYUPCOLNEWXFIELD.number = 3
Match3Def_pb.TIDYUPCOLNEWXFIELD.index = 2
Match3Def_pb.TIDYUPCOLNEWXFIELD.label = 3
Match3Def_pb.TIDYUPCOLNEWXFIELD.has_default_value = false
Match3Def_pb.TIDYUPCOLNEWXFIELD.default_value = {}
Match3Def_pb.TIDYUPCOLNEWXFIELD.type = 5
Match3Def_pb.TIDYUPCOLNEWXFIELD.cpp_type = 1
Match3Def_pb.TIDYUPCOL_MSG.name = "TidyUpCol"
Match3Def_pb.TIDYUPCOL_MSG.full_name = ".TidyUpCol"
Match3Def_pb.TIDYUPCOL_MSG.nested_types = {}
Match3Def_pb.TIDYUPCOL_MSG.enum_types = {}
Match3Def_pb.TIDYUPCOL_MSG.fields = {
	Match3Def_pb.TIDYUPCOLCOLFIELD,
	Match3Def_pb.TIDYUPCOLOLDXFIELD,
	Match3Def_pb.TIDYUPCOLNEWXFIELD
}
Match3Def_pb.TIDYUPCOL_MSG.is_extendable = false
Match3Def_pb.TIDYUPCOL_MSG.extensions = {}
Match3Def_pb.MATCH3TIPSFROMFIELD.name = "from"
Match3Def_pb.MATCH3TIPSFROMFIELD.full_name = ".Match3Tips.from"
Match3Def_pb.MATCH3TIPSFROMFIELD.number = 1
Match3Def_pb.MATCH3TIPSFROMFIELD.index = 0
Match3Def_pb.MATCH3TIPSFROMFIELD.label = 1
Match3Def_pb.MATCH3TIPSFROMFIELD.has_default_value = false
Match3Def_pb.MATCH3TIPSFROMFIELD.default_value = nil
Match3Def_pb.MATCH3TIPSFROMFIELD.message_type = Match3Def_pb.COORDINATE_MSG
Match3Def_pb.MATCH3TIPSFROMFIELD.type = 11
Match3Def_pb.MATCH3TIPSFROMFIELD.cpp_type = 10
Match3Def_pb.MATCH3TIPSTOFIELD.name = "to"
Match3Def_pb.MATCH3TIPSTOFIELD.full_name = ".Match3Tips.to"
Match3Def_pb.MATCH3TIPSTOFIELD.number = 2
Match3Def_pb.MATCH3TIPSTOFIELD.index = 1
Match3Def_pb.MATCH3TIPSTOFIELD.label = 1
Match3Def_pb.MATCH3TIPSTOFIELD.has_default_value = false
Match3Def_pb.MATCH3TIPSTOFIELD.default_value = nil
Match3Def_pb.MATCH3TIPSTOFIELD.message_type = Match3Def_pb.COORDINATE_MSG
Match3Def_pb.MATCH3TIPSTOFIELD.type = 11
Match3Def_pb.MATCH3TIPSTOFIELD.cpp_type = 10
Match3Def_pb.MATCH3TIPSELIMINATEFIELD.name = "eliminate"
Match3Def_pb.MATCH3TIPSELIMINATEFIELD.full_name = ".Match3Tips.eliminate"
Match3Def_pb.MATCH3TIPSELIMINATEFIELD.number = 3
Match3Def_pb.MATCH3TIPSELIMINATEFIELD.index = 2
Match3Def_pb.MATCH3TIPSELIMINATEFIELD.label = 1
Match3Def_pb.MATCH3TIPSELIMINATEFIELD.has_default_value = false
Match3Def_pb.MATCH3TIPSELIMINATEFIELD.default_value = nil
Match3Def_pb.MATCH3TIPSELIMINATEFIELD.message_type = Match3Def_pb.ELIMINATE_MSG
Match3Def_pb.MATCH3TIPSELIMINATEFIELD.type = 11
Match3Def_pb.MATCH3TIPSELIMINATEFIELD.cpp_type = 10
Match3Def_pb.MATCH3TIPS_MSG.name = "Match3Tips"
Match3Def_pb.MATCH3TIPS_MSG.full_name = ".Match3Tips"
Match3Def_pb.MATCH3TIPS_MSG.nested_types = {}
Match3Def_pb.MATCH3TIPS_MSG.enum_types = {}
Match3Def_pb.MATCH3TIPS_MSG.fields = {
	Match3Def_pb.MATCH3TIPSFROMFIELD,
	Match3Def_pb.MATCH3TIPSTOFIELD,
	Match3Def_pb.MATCH3TIPSELIMINATEFIELD
}
Match3Def_pb.MATCH3TIPS_MSG.is_extendable = false
Match3Def_pb.MATCH3TIPS_MSG.extensions = {}
Match3Def_pb.COORDINATEXFIELD.name = "x"
Match3Def_pb.COORDINATEXFIELD.full_name = ".Coordinate.x"
Match3Def_pb.COORDINATEXFIELD.number = 1
Match3Def_pb.COORDINATEXFIELD.index = 0
Match3Def_pb.COORDINATEXFIELD.label = 1
Match3Def_pb.COORDINATEXFIELD.has_default_value = false
Match3Def_pb.COORDINATEXFIELD.default_value = 0
Match3Def_pb.COORDINATEXFIELD.type = 5
Match3Def_pb.COORDINATEXFIELD.cpp_type = 1
Match3Def_pb.COORDINATEYFIELD.name = "y"
Match3Def_pb.COORDINATEYFIELD.full_name = ".Coordinate.y"
Match3Def_pb.COORDINATEYFIELD.number = 2
Match3Def_pb.COORDINATEYFIELD.index = 1
Match3Def_pb.COORDINATEYFIELD.label = 1
Match3Def_pb.COORDINATEYFIELD.has_default_value = false
Match3Def_pb.COORDINATEYFIELD.default_value = 0
Match3Def_pb.COORDINATEYFIELD.type = 5
Match3Def_pb.COORDINATEYFIELD.cpp_type = 1
Match3Def_pb.COORDINATE_MSG.name = "Coordinate"
Match3Def_pb.COORDINATE_MSG.full_name = ".Coordinate"
Match3Def_pb.COORDINATE_MSG.nested_types = {}
Match3Def_pb.COORDINATE_MSG.enum_types = {}
Match3Def_pb.COORDINATE_MSG.fields = {
	Match3Def_pb.COORDINATEXFIELD,
	Match3Def_pb.COORDINATEYFIELD
}
Match3Def_pb.COORDINATE_MSG.is_extendable = false
Match3Def_pb.COORDINATE_MSG.extensions = {}
Match3Def_pb.FILLCHESSBOARDDIRFIELD.name = "dir"
Match3Def_pb.FILLCHESSBOARDDIRFIELD.full_name = ".FillChessBoard.dir"
Match3Def_pb.FILLCHESSBOARDDIRFIELD.number = 1
Match3Def_pb.FILLCHESSBOARDDIRFIELD.index = 0
Match3Def_pb.FILLCHESSBOARDDIRFIELD.label = 1
Match3Def_pb.FILLCHESSBOARDDIRFIELD.has_default_value = false
Match3Def_pb.FILLCHESSBOARDDIRFIELD.default_value = 0
Match3Def_pb.FILLCHESSBOARDDIRFIELD.type = 5
Match3Def_pb.FILLCHESSBOARDDIRFIELD.cpp_type = 1
Match3Def_pb.FILLCHESSBOARDCHESSFIELD.name = "chess"
Match3Def_pb.FILLCHESSBOARDCHESSFIELD.full_name = ".FillChessBoard.chess"
Match3Def_pb.FILLCHESSBOARDCHESSFIELD.number = 2
Match3Def_pb.FILLCHESSBOARDCHESSFIELD.index = 1
Match3Def_pb.FILLCHESSBOARDCHESSFIELD.label = 3
Match3Def_pb.FILLCHESSBOARDCHESSFIELD.has_default_value = false
Match3Def_pb.FILLCHESSBOARDCHESSFIELD.default_value = {}
Match3Def_pb.FILLCHESSBOARDCHESSFIELD.message_type = Match3Def_pb.CHESS_MSG
Match3Def_pb.FILLCHESSBOARDCHESSFIELD.type = 11
Match3Def_pb.FILLCHESSBOARDCHESSFIELD.cpp_type = 10
Match3Def_pb.FILLCHESSBOARD_MSG.name = "FillChessBoard"
Match3Def_pb.FILLCHESSBOARD_MSG.full_name = ".FillChessBoard"
Match3Def_pb.FILLCHESSBOARD_MSG.nested_types = {}
Match3Def_pb.FILLCHESSBOARD_MSG.enum_types = {}
Match3Def_pb.FILLCHESSBOARD_MSG.fields = {
	Match3Def_pb.FILLCHESSBOARDDIRFIELD,
	Match3Def_pb.FILLCHESSBOARDCHESSFIELD
}
Match3Def_pb.FILLCHESSBOARD_MSG.is_extendable = false
Match3Def_pb.FILLCHESSBOARD_MSG.extensions = {}
Match3Def_pb.ELIMINATECOORDINATEFIELD.name = "coordinate"
Match3Def_pb.ELIMINATECOORDINATEFIELD.full_name = ".Eliminate.coordinate"
Match3Def_pb.ELIMINATECOORDINATEFIELD.number = 1
Match3Def_pb.ELIMINATECOORDINATEFIELD.index = 0
Match3Def_pb.ELIMINATECOORDINATEFIELD.label = 3
Match3Def_pb.ELIMINATECOORDINATEFIELD.has_default_value = false
Match3Def_pb.ELIMINATECOORDINATEFIELD.default_value = {}
Match3Def_pb.ELIMINATECOORDINATEFIELD.message_type = Match3Def_pb.COORDINATE_MSG
Match3Def_pb.ELIMINATECOORDINATEFIELD.type = 11
Match3Def_pb.ELIMINATECOORDINATEFIELD.cpp_type = 10
Match3Def_pb.ELIMINATEEXTRADATAFIELD.name = "extraData"
Match3Def_pb.ELIMINATEEXTRADATAFIELD.full_name = ".Eliminate.extraData"
Match3Def_pb.ELIMINATEEXTRADATAFIELD.number = 2
Match3Def_pb.ELIMINATEEXTRADATAFIELD.index = 1
Match3Def_pb.ELIMINATEEXTRADATAFIELD.label = 1
Match3Def_pb.ELIMINATEEXTRADATAFIELD.has_default_value = false
Match3Def_pb.ELIMINATEEXTRADATAFIELD.default_value = ""
Match3Def_pb.ELIMINATEEXTRADATAFIELD.type = 9
Match3Def_pb.ELIMINATEEXTRADATAFIELD.cpp_type = 9
Match3Def_pb.ELIMINATETYPEFIELD.name = "type"
Match3Def_pb.ELIMINATETYPEFIELD.full_name = ".Eliminate.type"
Match3Def_pb.ELIMINATETYPEFIELD.number = 3
Match3Def_pb.ELIMINATETYPEFIELD.index = 2
Match3Def_pb.ELIMINATETYPEFIELD.label = 1
Match3Def_pb.ELIMINATETYPEFIELD.has_default_value = false
Match3Def_pb.ELIMINATETYPEFIELD.default_value = ""
Match3Def_pb.ELIMINATETYPEFIELD.type = 9
Match3Def_pb.ELIMINATETYPEFIELD.cpp_type = 9
Match3Def_pb.ELIMINATESOURCEFIELD.name = "source"
Match3Def_pb.ELIMINATESOURCEFIELD.full_name = ".Eliminate.source"
Match3Def_pb.ELIMINATESOURCEFIELD.number = 4
Match3Def_pb.ELIMINATESOURCEFIELD.index = 3
Match3Def_pb.ELIMINATESOURCEFIELD.label = 1
Match3Def_pb.ELIMINATESOURCEFIELD.has_default_value = false
Match3Def_pb.ELIMINATESOURCEFIELD.default_value = 0
Match3Def_pb.ELIMINATESOURCEFIELD.type = 5
Match3Def_pb.ELIMINATESOURCEFIELD.cpp_type = 1
Match3Def_pb.ELIMINATE_MSG.name = "Eliminate"
Match3Def_pb.ELIMINATE_MSG.full_name = ".Eliminate"
Match3Def_pb.ELIMINATE_MSG.nested_types = {}
Match3Def_pb.ELIMINATE_MSG.enum_types = {}
Match3Def_pb.ELIMINATE_MSG.fields = {
	Match3Def_pb.ELIMINATECOORDINATEFIELD,
	Match3Def_pb.ELIMINATEEXTRADATAFIELD,
	Match3Def_pb.ELIMINATETYPEFIELD,
	Match3Def_pb.ELIMINATESOURCEFIELD
}
Match3Def_pb.ELIMINATE_MSG.is_extendable = false
Match3Def_pb.ELIMINATE_MSG.extensions = {}
Match3Def_pb.TIDYUPCOLFIELD.name = "col"
Match3Def_pb.TIDYUPCOLFIELD.full_name = ".TidyUp.col"
Match3Def_pb.TIDYUPCOLFIELD.number = 1
Match3Def_pb.TIDYUPCOLFIELD.index = 0
Match3Def_pb.TIDYUPCOLFIELD.label = 3
Match3Def_pb.TIDYUPCOLFIELD.has_default_value = false
Match3Def_pb.TIDYUPCOLFIELD.default_value = {}
Match3Def_pb.TIDYUPCOLFIELD.message_type = Match3Def_pb.TIDYUPCOL_MSG
Match3Def_pb.TIDYUPCOLFIELD.type = 11
Match3Def_pb.TIDYUPCOLFIELD.cpp_type = 10
Match3Def_pb.TIDYUPROWFIELD.name = "row"
Match3Def_pb.TIDYUPROWFIELD.full_name = ".TidyUp.row"
Match3Def_pb.TIDYUPROWFIELD.number = 2
Match3Def_pb.TIDYUPROWFIELD.index = 1
Match3Def_pb.TIDYUPROWFIELD.label = 3
Match3Def_pb.TIDYUPROWFIELD.has_default_value = false
Match3Def_pb.TIDYUPROWFIELD.default_value = {}
Match3Def_pb.TIDYUPROWFIELD.message_type = Match3Def_pb.TIDYUPROW_MSG
Match3Def_pb.TIDYUPROWFIELD.type = 11
Match3Def_pb.TIDYUPROWFIELD.cpp_type = 10
Match3Def_pb.TIDYUP_MSG.name = "TidyUp"
Match3Def_pb.TIDYUP_MSG.full_name = ".TidyUp"
Match3Def_pb.TIDYUP_MSG.nested_types = {}
Match3Def_pb.TIDYUP_MSG.enum_types = {}
Match3Def_pb.TIDYUP_MSG.fields = {
	Match3Def_pb.TIDYUPCOLFIELD,
	Match3Def_pb.TIDYUPROWFIELD
}
Match3Def_pb.TIDYUP_MSG.is_extendable = false
Match3Def_pb.TIDYUP_MSG.extensions = {}
Match3Def_pb.CHESSBOARDROWCHESSFIELD.name = "chess"
Match3Def_pb.CHESSBOARDROWCHESSFIELD.full_name = ".ChessBoardRow.chess"
Match3Def_pb.CHESSBOARDROWCHESSFIELD.number = 1
Match3Def_pb.CHESSBOARDROWCHESSFIELD.index = 0
Match3Def_pb.CHESSBOARDROWCHESSFIELD.label = 3
Match3Def_pb.CHESSBOARDROWCHESSFIELD.has_default_value = false
Match3Def_pb.CHESSBOARDROWCHESSFIELD.default_value = {}
Match3Def_pb.CHESSBOARDROWCHESSFIELD.message_type = Match3Def_pb.CHESS_MSG
Match3Def_pb.CHESSBOARDROWCHESSFIELD.type = 11
Match3Def_pb.CHESSBOARDROWCHESSFIELD.cpp_type = 10
Match3Def_pb.CHESSBOARDROW_MSG.name = "ChessBoardRow"
Match3Def_pb.CHESSBOARDROW_MSG.full_name = ".ChessBoardRow"
Match3Def_pb.CHESSBOARDROW_MSG.nested_types = {}
Match3Def_pb.CHESSBOARDROW_MSG.enum_types = {}
Match3Def_pb.CHESSBOARDROW_MSG.fields = {
	Match3Def_pb.CHESSBOARDROWCHESSFIELD
}
Match3Def_pb.CHESSBOARDROW_MSG.is_extendable = false
Match3Def_pb.CHESSBOARDROW_MSG.extensions = {}
Match3Def_pb.TIDYUPROWROWFIELD.name = "row"
Match3Def_pb.TIDYUPROWROWFIELD.full_name = ".TidyUpRow.row"
Match3Def_pb.TIDYUPROWROWFIELD.number = 1
Match3Def_pb.TIDYUPROWROWFIELD.index = 0
Match3Def_pb.TIDYUPROWROWFIELD.label = 1
Match3Def_pb.TIDYUPROWROWFIELD.has_default_value = false
Match3Def_pb.TIDYUPROWROWFIELD.default_value = 0
Match3Def_pb.TIDYUPROWROWFIELD.type = 5
Match3Def_pb.TIDYUPROWROWFIELD.cpp_type = 1
Match3Def_pb.TIDYUPROWOLDYFIELD.name = "oldY"
Match3Def_pb.TIDYUPROWOLDYFIELD.full_name = ".TidyUpRow.oldY"
Match3Def_pb.TIDYUPROWOLDYFIELD.number = 2
Match3Def_pb.TIDYUPROWOLDYFIELD.index = 1
Match3Def_pb.TIDYUPROWOLDYFIELD.label = 3
Match3Def_pb.TIDYUPROWOLDYFIELD.has_default_value = false
Match3Def_pb.TIDYUPROWOLDYFIELD.default_value = {}
Match3Def_pb.TIDYUPROWOLDYFIELD.type = 5
Match3Def_pb.TIDYUPROWOLDYFIELD.cpp_type = 1
Match3Def_pb.TIDYUPROWNEWYFIELD.name = "newY"
Match3Def_pb.TIDYUPROWNEWYFIELD.full_name = ".TidyUpRow.newY"
Match3Def_pb.TIDYUPROWNEWYFIELD.number = 3
Match3Def_pb.TIDYUPROWNEWYFIELD.index = 2
Match3Def_pb.TIDYUPROWNEWYFIELD.label = 3
Match3Def_pb.TIDYUPROWNEWYFIELD.has_default_value = false
Match3Def_pb.TIDYUPROWNEWYFIELD.default_value = {}
Match3Def_pb.TIDYUPROWNEWYFIELD.type = 5
Match3Def_pb.TIDYUPROWNEWYFIELD.cpp_type = 1
Match3Def_pb.TIDYUPROW_MSG.name = "TidyUpRow"
Match3Def_pb.TIDYUPROW_MSG.full_name = ".TidyUpRow"
Match3Def_pb.TIDYUPROW_MSG.nested_types = {}
Match3Def_pb.TIDYUPROW_MSG.enum_types = {}
Match3Def_pb.TIDYUPROW_MSG.fields = {
	Match3Def_pb.TIDYUPROWROWFIELD,
	Match3Def_pb.TIDYUPROWOLDYFIELD,
	Match3Def_pb.TIDYUPROWNEWYFIELD
}
Match3Def_pb.TIDYUPROW_MSG.is_extendable = false
Match3Def_pb.TIDYUPROW_MSG.extensions = {}
Match3Def_pb.MATCH3TURNELIMINATEFIELD.name = "eliminate"
Match3Def_pb.MATCH3TURNELIMINATEFIELD.full_name = ".Match3Turn.eliminate"
Match3Def_pb.MATCH3TURNELIMINATEFIELD.number = 1
Match3Def_pb.MATCH3TURNELIMINATEFIELD.index = 0
Match3Def_pb.MATCH3TURNELIMINATEFIELD.label = 3
Match3Def_pb.MATCH3TURNELIMINATEFIELD.has_default_value = false
Match3Def_pb.MATCH3TURNELIMINATEFIELD.default_value = {}
Match3Def_pb.MATCH3TURNELIMINATEFIELD.message_type = Match3Def_pb.ELIMINATE_MSG
Match3Def_pb.MATCH3TURNELIMINATEFIELD.type = 11
Match3Def_pb.MATCH3TURNELIMINATEFIELD.cpp_type = 10
Match3Def_pb.MATCH3TURNTIDYUPFIELD.name = "tidyUp"
Match3Def_pb.MATCH3TURNTIDYUPFIELD.full_name = ".Match3Turn.tidyUp"
Match3Def_pb.MATCH3TURNTIDYUPFIELD.number = 2
Match3Def_pb.MATCH3TURNTIDYUPFIELD.index = 1
Match3Def_pb.MATCH3TURNTIDYUPFIELD.label = 1
Match3Def_pb.MATCH3TURNTIDYUPFIELD.has_default_value = false
Match3Def_pb.MATCH3TURNTIDYUPFIELD.default_value = nil
Match3Def_pb.MATCH3TURNTIDYUPFIELD.message_type = Match3Def_pb.TIDYUP_MSG
Match3Def_pb.MATCH3TURNTIDYUPFIELD.type = 11
Match3Def_pb.MATCH3TURNTIDYUPFIELD.cpp_type = 10
Match3Def_pb.MATCH3TURNFILLCHESSBOARDFIELD.name = "fillChessBoard"
Match3Def_pb.MATCH3TURNFILLCHESSBOARDFIELD.full_name = ".Match3Turn.fillChessBoard"
Match3Def_pb.MATCH3TURNFILLCHESSBOARDFIELD.number = 3
Match3Def_pb.MATCH3TURNFILLCHESSBOARDFIELD.index = 2
Match3Def_pb.MATCH3TURNFILLCHESSBOARDFIELD.label = 1
Match3Def_pb.MATCH3TURNFILLCHESSBOARDFIELD.has_default_value = false
Match3Def_pb.MATCH3TURNFILLCHESSBOARDFIELD.default_value = nil
Match3Def_pb.MATCH3TURNFILLCHESSBOARDFIELD.message_type = Match3Def_pb.FILLCHESSBOARD_MSG
Match3Def_pb.MATCH3TURNFILLCHESSBOARDFIELD.type = 11
Match3Def_pb.MATCH3TURNFILLCHESSBOARDFIELD.cpp_type = 10
Match3Def_pb.MATCH3TURN_MSG.name = "Match3Turn"
Match3Def_pb.MATCH3TURN_MSG.full_name = ".Match3Turn"
Match3Def_pb.MATCH3TURN_MSG.nested_types = {}
Match3Def_pb.MATCH3TURN_MSG.enum_types = {}
Match3Def_pb.MATCH3TURN_MSG.fields = {
	Match3Def_pb.MATCH3TURNELIMINATEFIELD,
	Match3Def_pb.MATCH3TURNTIDYUPFIELD,
	Match3Def_pb.MATCH3TURNFILLCHESSBOARDFIELD
}
Match3Def_pb.MATCH3TURN_MSG.is_extendable = false
Match3Def_pb.MATCH3TURN_MSG.extensions = {}
Match3Def_pb.Chess = protobuf.Message(Match3Def_pb.CHESS_MSG)
Match3Def_pb.ChessBoardRow = protobuf.Message(Match3Def_pb.CHESSBOARDROW_MSG)
Match3Def_pb.Coordinate = protobuf.Message(Match3Def_pb.COORDINATE_MSG)
Match3Def_pb.Eliminate = protobuf.Message(Match3Def_pb.ELIMINATE_MSG)
Match3Def_pb.FillChessBoard = protobuf.Message(Match3Def_pb.FILLCHESSBOARD_MSG)
Match3Def_pb.Match3ChessBoard = protobuf.Message(Match3Def_pb.MATCH3CHESSBOARD_MSG)
Match3Def_pb.Match3Tips = protobuf.Message(Match3Def_pb.MATCH3TIPS_MSG)
Match3Def_pb.Match3Turn = protobuf.Message(Match3Def_pb.MATCH3TURN_MSG)
Match3Def_pb.TidyUp = protobuf.Message(Match3Def_pb.TIDYUP_MSG)
Match3Def_pb.TidyUpCol = protobuf.Message(Match3Def_pb.TIDYUPCOL_MSG)
Match3Def_pb.TidyUpRow = protobuf.Message(Match3Def_pb.TIDYUPROW_MSG)

return Match3Def_pb
