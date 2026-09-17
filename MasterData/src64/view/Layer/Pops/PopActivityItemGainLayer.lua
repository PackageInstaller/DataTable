PopActivityItemGainLayer = class("PopActivityItemGainLayer", function()
	return PopBaseLayer:create()
end)

local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local discount_manager = require("controller.discount_manager")
local recharge_data = require("data.recharge_data")
local recharge_manager = require("controller.recharge_manager")
local network = require("network.network")
local var_0_10 = config._DEBUG and 0 or 1
local var_0_12 = 150

function PopActivityItemGainLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopActivityItemGainLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopActivityItemGainLayer:init(arg_3_1)
	self.rootLayer = cc.Layer:create()

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootLayer:setTouchEnabled(false)
	self:addChild(self.rootLayer, 2)

	self.activityId = arg_3_1.activityId
	self.type = arg_3_1.type

	self:initImgPath()
	self:initData()
	self:initUI(arg_3_1)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			popstarrewardlayerInstance = false

			if arg_3_1.updateCallback then
				arg_3_1.updateCallback()
			end

			activity_manager:releaseEventListenerByName("PopActivityItemGainLayer")
		end
	end)
end

function PopActivityItemGainLayer:initImgPath()
	self.imgPath = string.format(({
		roulette = "ActivityRoulette_%d",
		multi_pt = "Activity_multiPt_%d"
	})[self.type or "roulette"], self.activityId)
end

function PopActivityItemGainLayer:initData()
	self.itemList = ({
		roultte = {
			[209] = {
				1720901,
				"buy_1",
				2000209,
				2500209
			},
			[210] = {
				1721004,
				"buy_1",
				2000210,
				2500210
			},
			[223] = {
				"buy_1",
				"buy_2",
				1522301
			},
			[227] = {
				"buy_1",
				1722701,
				2000227
			},
			[230] = {
				2000230,
				4003,
				1523001,
				1800299,
				2500230
			},
			[284] = {
				2500284,
				"buy_1",
				"buy_2"
			},
			[286] = {
				"buy_1",
				"buy_2",
				"buy_3",
				1500010,
				2000286,
				2500286,
				1728601
			},
			[293] = {
				2500293,
				"buy_1",
				"buy_2"
			},
			[298] = {
				"buy_1",
				"buy_2",
				"buy_3",
				2000298,
				2700298,
				2500298
			},
			[299] = {
				2500299,
				"buy_1",
				"buy_2"
			},
			[300] = {
				"buy_1",
				"buy_2",
				"buy_3",
				2000300,
				2500300,
				1730011
			},
			[304] = {
				"buy_1",
				"buy_2",
				"buy_3",
				4007304,
				2500304
			},
			[319] = {
				2500319,
				"buy_1",
				"buy_2"
			},
			[326] = {
				"buy_1",
				"buy_2",
				"buy_3",
				2500326
			},
			[315] = {
				"buy_1",
				"buy_2",
				"buy_3",
				2000315,
				2500315
			},
			[327] = {
				2500327,
				"buy_1",
				"buy_2"
			},
			[330] = {
				"buy_1",
				"buy_2",
				"buy_3",
				1533001
			},
			[333] = {
				"buy_1",
				"buy_2",
				"buy_3",
				1533001
			},
			[404] = {
				"buy_1",
				"buy_2",
				"buy_3",
				2000404,
				2500404,
				1740401
			},
			[421] = {
				"buy_1",
				"buy_2",
				"buy_3",
				1542101
			},
			[417] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[418] = {
				"buy_1",
				"buy_2",
				"buy_3",
				1541801
			},
			[430] = {
				"buy_1",
				"buy_2",
				"buy_3",
				1543002,
				3900430
			},
			[418] = {
				"buy_1",
				"buy_2",
				"buy_3",
				1541801
			},
			[428] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[442] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[453] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[461] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[457] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[463] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[471] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[479] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[485] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[490] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[492] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[500] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[508] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[511] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[521] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[527] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[522] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[533] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[530] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[534] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[538] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[541] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[537] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[546] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[550] = {
				"buy_1",
				"buy_2",
				"buy_3",
				1555001
			},
			[552] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[560] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[562] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[574] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[573] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[575] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[569] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[582] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[576] = {
				"buy_1",
				"buy_2",
				"buy_3",
				1557601,
				3900576
			},
			[584] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[588] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[591] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[591] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[594] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[593] = {
				"buy_1",
				"buy_2",
				"buy_3",
				1559301,
				3900593
			},
			[599] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[707] = {
				"buy_1",
				"buy_2",
				"buy_3",
				3900707,
				1570701
			},
			[709] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[708] = {
				"buy_1",
				"buy_2",
				"buy_3",
				1546402
			},
			[712] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[714] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[716] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[713] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[721] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[723] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[725] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[727] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[722] = {
				"buy_1",
				"buy_2",
				"buy_3",
				1572201,
				3900722
			},
			[728] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[729] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[731] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[748] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[745] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[755] = {
				"buy_1",
				"buy_2",
				"buy_3",
				3900755,
				1575504
			},
			[758] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[761] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[768] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[766] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[773] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[767] = {
				"buy_1",
				"buy_2",
				"buy_3",
				3900767,
				1576704
			},
			[781] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[776] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[775] = {
				"buy_1",
				"buy_2",
				"buy_3",
				3900775,
				1577502
			},
			[785] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[787] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[792] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[806] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[818] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[813] = {
				"buy_1",
				"buy_2",
				"buy_3",
				3900813,
				1581302
			},
			[830] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[837] = {
				"buy_1",
				"buy_2",
				"buy_3",
				3900837
			},
			[838] = {
				"buy_1",
				"buy_2",
				"buy_3",
				3900838,
				1583804
			},
			[852] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[855] = {
				"buy_1",
				"buy_2",
				"buy_3",
				3900855,
				1585504
			},
			[861] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[866] = {
				"buy_1",
				"buy_2",
				"buy_3",
				3900866,
				1586602
			},
			[865] = {
				"buy_1",
				"buy_2",
				"buy_3",
				3900865,
				1586502
			},
			[868] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[872] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[887] = {
				"buy_1",
				"buy_2",
				"buy_3"
			},
			[888] = {
				"buy_1",
				"buy_2",
				"buy_3",
				3900888,
				1588802
			},
			[891] = {
				"buy_1",
				"buy_2",
				"buy_3"
			}
		},
		multi_pt = {
			[230] = {
				2000230,
				2500230,
				4003,
				1800299
			},
			[248] = {
				1800302,
				2000248,
				2300248,
				2900248,
				2500248
			},
			[252] = {
				1800306,
				2000252,
				2300252,
				2900252,
				2500252
			},
			[266] = {
				1800310,
				2000266,
				2300266,
				2900266,
				2500266
			},
			[270] = {
				2000270,
				2300270,
				1527001
			},
			[264] = {
				1800311,
				2000264,
				2300264,
				2900264,
				2500264
			},
			[275] = {
				1800317,
				2000275,
				2300275,
				2900275,
				2500275
			},
			[279] = {
				1800319,
				2000279,
				2300279,
				2900279,
				2500279
			},
			[283] = {
				1800326,
				2000283,
				2300283,
				2900283,
				2500283
			},
			[286] = {
				2000286,
				2300286,
				4004286
			},
			[288] = {
				1800337,
				2000288,
				2300288,
				2900288,
				2500288
			},
			[297] = {
				1800350,
				2000297,
				2300297,
				2900297,
				2500297
			},
			[298] = {
				2000298,
				2500298,
				2300298
			},
			[300] = {
				2500300,
				2000300,
				4004300,
				4004300
			},
			[304] = {
				4004304,
				4004304,
				4004304,
				4004304,
				2500304
			},
			[312] = {
				4004312,
				4004312,
				4004312,
				2500312
			},
			[320] = {
				1800367,
				2000320,
				2300320,
				2900320,
				2500320
			},
			[322] = {
				1800378,
				2000322,
				2300322,
				2900322,
				2500322
			},
			[326] = {
				4004326,
				4004326,
				4004326,
				2500326
			},
			[329] = {
				1800389,
				2000329,
				2300329,
				2900329,
				2500329
			},
			[330] = {
				2500330,
				4004330,
				4004330,
				4004330
			},
			[333] = {
				2500333,
				4004333,
				4004333,
				4004333
			},
			[330] = {
				2500330,
				4004330,
				4004330,
				4004330
			},
			[334] = {
				4004334,
				2500334,
				4004334,
				4004334
			},
			[405] = {
				2500405,
				4004405,
				4004405,
				4004405
			},
			[413] = {
				1800420,
				2000413,
				2300413,
				2900413,
				2500413
			},
			[415] = {
				1800415,
				2000415,
				2300415,
				2900415,
				2500415
			},
			[421] = {
				2500421,
				2000421,
				4004421,
				4004421,
				4004421
			},
			[417] = {
				2500417,
				4004417,
				4004417
			},
			[420] = {
				1800425,
				2000420,
				2300420,
				2900420,
				2500420
			},
			[433] = {
				2000433,
				1800440,
				2900433,
				2500433,
				2300433
			},
			[418] = {
				2500418,
				4004418,
				4004418,
				4004418
			},
			[430] = {
				4004430,
				2500430,
				4004
			},
			[428] = {
				2000428,
				2500428,
				4004428
			},
			[436] = {
				4004436,
				2500436,
				4004436,
				4004436
			},
			[444] = {
				1800457,
				2000444,
				2300444,
				2900444,
				2500444
			},
			[450] = {
				4007450,
				4004450
			},
			[442] = {
				4004442,
				2500442,
				4004442,
				4004442
			},
			[451] = {
				2900451,
				2300451,
				2500451
			},
			[453] = {
				2500453,
				4004453,
				4004453
			},
			[457] = {
				2500457,
				4004457,
				1900457
			},
			[458] = {
				4004458,
				4004458,
				4004458,
				2500458
			},
			[464] = {
				2000464,
				2300464,
				1746401
			},
			[461] = {
				2500461,
				4004461,
				4004461
			},
			[462] = {
				2500462,
				4004462,
				4004462
			},
			[463] = {
				2500463,
				4004463,
				4004463,
				4004463
			},
			[465] = {
				2500465,
				2300465,
				2900465,
				2900465
			},
			[471] = {
				2500471,
				4004471,
				4004471
			},
			[479] = {
				4004479,
				4004479,
				4004326,
				2500479
			},
			[478] = {
				2900478,
				2500478,
				1900478
			},
			[481] = {
				4004481,
				4004481,
				1900481
			},
			[490] = {
				4004490,
				4004490,
				4004490,
				4004490,
				2500490
			},
			[492] = {
				2500492,
				4004492,
				4004492
			},
			[500] = {
				2500500,
				4004500,
				3900500
			},
			[507] = {
				2500507,
				4004507,
				3900507
			},
			[508] = {
				2500508,
				2000508,
				4004508,
				4004508
			},
			[512] = {
				4004512,
				4004512,
				4004512,
				2500512
			},
			[511] = {
				2500511,
				4004511,
				3900511
			},
			[521] = {
				2500521,
				4004521,
				3900521
			},
			[526] = {
				2000526,
				4004526,
				2500526
			},
			[527] = {
				2500527,
				4004527,
				4004527
			},
			[522] = {
				2500522,
				4004522,
				4004522
			},
			[533] = {
				4004533,
				2500533,
				3900533
			},
			[529] = {
				2000529,
				2500529,
				4004529
			},
			[530] = {
				2000530,
				4004530,
				2500530
			},
			[534] = {
				2000534,
				4004534,
				2500534
			},
			[538] = {
				2000538,
				4004538,
				2500538
			},
			[541] = {
				2000541,
				4004541,
				2500541
			},
			[537] = {
				4004537,
				2500537
			},
			[542] = {
				2000542,
				4004542,
				2500542
			},
			[545] = {
				2500545,
				4004545,
				3900545
			},
			[547] = {
				2000547,
				4004547,
				2500547
			},
			[550] = {
				1900550,
				4004550,
				2500550
			},
			[543] = {
				2900543,
				2900543,
				2500543
			},
			[552] = {
				2500552,
				4004552,
				3900552
			},
			[561] = {
				2500561,
				4004561,
				3900561
			},
			[557] = {
				2500557,
				4004557,
				3900557
			},
			[560] = {
				2500560,
				4004560,
				3900560
			},
			[563] = {
				2500563,
				4004563,
				3900563
			},
			[562] = {
				4004562,
				2500562,
				3900562
			},
			[565] = {
				2500565,
				4004565,
				4004565,
				4004565
			},
			[570] = {
				2500570,
				4004570,
				3900570
			},
			[574] = {
				2500574,
				4004574,
				3900574
			},
			[573] = {
				2000573,
				200,
				3900573
			},
			[575] = {
				2500575,
				4004575,
				3900575
			},
			[569] = {
				2500569,
				4004569,
				4004569,
				4004569
			},
			[576] = {
				4004576,
				2500576,
				1900576
			},
			[584] = {
				4004584,
				2500584,
				3900584
			},
			[588] = {
				2500588,
				4004588,
				3900588
			},
			[591] = {
				4004591,
				2500591,
				3900591
			},
			[589] = {
				4004589,
				2500589,
				3900589
			},
			[594] = {
				2500594,
				4004594,
				3900594
			},
			[593] = {
				2500593,
				4004593,
				1900593
			},
			[599] = {
				2500599,
				4004599,
				3900599
			},
			[700] = {
				2500700,
				4004700
			},
			[703] = {
				4004703,
				2500703
			},
			[707] = {
				2500707,
				4004707,
				3900707
			},
			[708] = {
				2500708,
				2300708,
				3900708
			},
			[709] = {
				2500709,
				4004709,
				3900709
			},
			[714] = {
				2500714,
				4004714
			},
			[713] = {
				4004713,
				2500713
			},
			[717] = {
				2500717,
				4004717,
				3900717
			},
			[719] = {
				2500719,
				2900719,
				2900719
			},
			[721] = {
				2500721,
				4004721,
				3900721
			},
			[723] = {
				2500723,
				2900723,
				2900723
			},
			[720] = {
				2500720,
				4004720,
				3900720
			},
			[722] = {
				2500722,
				4004722,
				3900722
			},
			[728] = {
				2500728,
				4004728,
				3900728
			},
			[745] = {
				2500745,
				4004745
			},
			[755] = {
				2500755,
				4004755,
				3900755
			},
			[758] = {
				3900758,
				4004758,
				2500758
			},
			[761] = {
				4004761,
				2500761,
				3900761
			},
			[768] = {
				2900768,
				2500768,
				220
			},
			[766] = {
				1900766,
				4004766,
				2500766
			},
			[773] = {
				4004773,
				2500773,
				4007773
			},
			[767] = {
				2500767,
				4004767,
				3900767
			},
			[776] = {
				2500776,
				4004776,
				3900776
			},
			[775] = {
				2500775,
				4004775,
				3900775
			},
			[792] = {
				4007792,
				4004792,
				2500792
			},
			[805] = {
				4007805,
				2500805,
				4004805
			},
			[792] = {
				4007806,
				4004806,
				2500806
			},
			[806] = {
				4007806,
				4004806,
				2500806
			},
			[811] = {
				4004811,
				2500811
			},
			[818] = {
				2500818,
				4004818,
				3900818
			},
			[830] = {
				4007830,
				2500830,
				4004830
			},
			[837] = {
				2500837,
				4004837,
				3900837
			},
			[838] = {
				2500838,
				4007838,
				3900838,
				4004838
			},
			[846] = {
				2500846,
				4004846,
				3900846
			},
			[852] = {
				2900852,
				2500852,
				220
			},
			[855] = {
				2500855,
				4004855,
				3900855
			},
			[861] = {
				4007861,
				2500861,
				4004861
			},
			[866] = {
				2500866,
				4004866,
				3900866
			},
			[865] = {
				2500865,
				4004865,
				3900865
			},
			[872] = {
				4007872,
				2500872,
				4004872
			},
			[876] = {
				2500876,
				2900876,
				2900876
			},
			[881] = {
				2500881,
				2900881,
				2900881
			},
			[887] = {
				2900887,
				2900887,
				2900887
			},
			[888] = {
				2500888,
				4004888,
				3900888
			},
			[891] = {
				2900891,
				2900891,
				2900891
			},
			[892] = {
				4004892,
				2500892,
				3900892
			}
		}
	})[self.type or "roultte"][self.activityId]
end

function PopActivityItemGainLayer:initUI()
	self:initBGAndTitle()
	self:addTouchEventMask()
	self:playJoinEffect()
	self:initButtons()
end

function PopActivityItemGainLayer:addTouchEventMask()
	self:createFullScreenMask(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_9_0:isBright() then
			return
		end

		arg_9_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
end

function PopActivityItemGainLayer:playJoinEffect()
	self.rootpanel:setScaleY(0.1)
	self.rootpanel:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 1)))
end

function PopActivityItemGainLayer:initBGAndTitle()
	self.rootpanel = ccui.ImageView:create(self.imgPath .. "/buy_bg.png", var_0_10)

	self.rootpanel:setPosition(cc.p(320, GameDisplay.getScreenSize().height / 2 + 50))
	self.rootpanel:setTouchEnabled(true)
	self.rootLayer:addChild(self.rootpanel)

	local var_12_0 = ccui.ImageView:create(self.imgPath .. "/gain_title.png", var_0_10)

	var_12_0:setPosition(cc.p(320, 860))
	self.rootpanel:addChild(var_12_0)

	local var_12_1 = ccui.Layout:create()

	var_12_1:setContentSize(cc.size(GameDisplay.width, 100))
	var_12_1:setAnchorPoint(cc.p(0, 0))
	var_12_1:setPosition(cc.p(0, 0))
	var_12_1:setTouchEnabled(true)
	self.rootLayer:addChild(var_12_1, 20000)
	var_12_1:setTouchEnabled(true)
	var_12_1:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
end

local var_0_13 = {
	[837] = 180,
	[887] = 200,
	[888] = 170,
	[891] = 200,
	[892] = 200,
	[731] = 180,
	[881] = 190,
	[745] = 180
}
local var_0_14 = {
	[861] = 300,
	[865] = 300,
	[298] = 350,
	[888] = 300
}

function PopActivityItemGainLayer:initButtons()
	if #self.itemList == 1 then
		self.rootpanel:addTouchEventListener(function(arg_16_0, arg_16_1)
			goto_complete_system({
				jump_to_system = self.itemList[1]
			})
			AnalyticManager.activityJumpTo({
				activityid = self.activityId,
				module = self.type,
				jump = self.itemList[1]
			})
		end)

		return
	end

	local var_15_0 = self.rootpanel:getContentSize()

	if not self.type then
		-- block empty
	end

	self.itemView = cc.TableView:create(cc.size(var_15_0.width, var_15_0.height - (var_0_14[self.activityId] or 150)))

	self.itemView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.itemView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.itemView:setAnchorPoint(cc.p(0, 0))
	self.itemView:setPosition(10, 10)
	self.itemView:setDelegate()
	self.rootpanel:addChild(self.itemView)
	self.itemView:registerScriptHandler(function(arg_18_0, arg_18_1)
		return 520, var_0_13[self.activityId] or var_0_12
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.itemView:registerScriptHandler(function(arg_17_0, arg_17_1)
		local var_17_0 = arg_17_0:dequeueCell()

		if not var_17_0 then
			var_17_0 = cc.TableViewCell:create()

			local var_17_2 = self:createItemSprite(arg_17_1 + 1)

			var_17_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_17_2:setPosition(cc.p(var_15_0.width / 2 - 10, var_0_12 / 2))
			var_17_0:addChild(var_17_2)
		else
			self:updateItemSprite(var_17_0:getChildByTag(100), arg_17_1 + 1)
		end

		return var_17_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.itemView:registerScriptHandler(function(arg_19_0, arg_19_1)
		return #self.itemList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.itemView:reloadData()
end

function PopActivityItemGainLayer:createItemSprite(arg_20_1)
	local var_20_0 = string.format(self.imgPath .. "/go_gain_%s.png", arg_20_1)
	local var_20_1 = ccui.Button:create(var_20_0, nil, var_20_0, var_0_10)

	var_20_1:setTag(100)
	var_20_1:setSwallowTouches(false)
	var_20_1:addTouchEventListener(function(arg_21_0, arg_21_1)
		if math.abs(arg_21_0:getTouchBeganPosition().y - arg_21_0:getTouchEndPosition().y) > 15 then
			return
		end

		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if type(self.itemList[arg_20_1]) == "string" and self.itemList[arg_20_1]:find("buy") then
			self:buyActivityItem(self.itemList[arg_20_1])
		else
			goto_complete_system({
				jump_to_system = self.itemList[arg_20_1]
			})
		end

		AnalyticManager.activityJumpTo({
			activityid = self.activityId,
			module = self.type,
			jump = self.itemList[arg_20_1]
		})
	end)

	return var_20_1
end

function PopActivityItemGainLayer:updateItemSprite(arg_22_1, arg_22_2)
	local var_22_0 = string.format(self.imgPath .. "/go_gain_%s.png", arg_22_2)

	arg_22_1:loadTextures(var_22_0, nil, var_22_0, var_0_10)
	arg_22_1:addTouchEventListener(function(arg_23_0, arg_23_1)
		if math.abs(arg_23_0:getTouchBeganPosition().y - arg_23_0:getTouchEndPosition().y) > 15 then
			return
		end

		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		if type(self.itemList[arg_22_2]) == "string" and self.itemList[arg_22_2]:find("buy") then
			self:buyActivityItem(self.itemList[arg_22_2])
		else
			goto_complete_system({
				jump_to_system = self.itemList[arg_22_2]
			})
		end

		AnalyticManager.activityJumpTo({
			activityid = self.activityId,
			module = self.type,
			jump = self.itemList[arg_22_2]
		})
	end)
	arg_22_1:setTag(100)
end

function PopActivityItemGainLayer:buyActivityItem(arg_24_1)
	activity_manager:buyActivityItem(self.activityId, tonumber(string.match(arg_24_1, "buy_(%d+)")) or 1)
end
