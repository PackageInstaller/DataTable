-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/ToLua/Lua/jit/dis_ppc.lua

local type = type
local byte, format = string.byte, string.format
local match, gmatch, gsub = string.match, string.gmatch, string.gsub
local concat = table.concat
local bit = require("bit")
local band, bor, tohex = bit.band, bit.bor, bit.tohex
local lshift, rshift, arshift = bit.lshift, bit.rshift, bit.arshift
local map_crops = {
	[0] = "mcrfXX",
	[289] = "creqv|crsetCCC%",
	[257] = "crandCCC",
	[225] = "crnandCCC",
	mask = 1023,
	[150] = "isync",
	[129] = "crandcCCC",
	[16] = "b_lrKB",
	[33] = "crnor|crnotCCC=",
	[528] = "b_ctrKB",
	[417] = "crorcCCC",
	[449] = "cror|crmoveCCC=",
	[193] = "crxor|crclrCCC%",
	shift = 1
}
local map_rlwinm = setmetatable({
	shift = 0,
	mask = -1
}, {
	__index = function(t, x)
		local rot = band(rshift(x, 11), 31)
		local mb = band(rshift(x, 6), 31)
		local me = band(rshift(x, 1), 31)

		if mb == 0 and me == 31 - rot then
			return "slwiRR~A."
		elseif me == 31 and mb == 32 - rot then
			return "srwiRR~-A."
		else
			return "rlwinmRR~AAA."
		end
	end
})
local map_rld = {
	[0] = "rldiclRR~HM.",
	"rldicrRR~HM.",
	"rldicRR~HM.",
	"rldimiRR~HM.",
	{
		[0] = "rldclRR~RM.",
		"rldcrRR~RM.",
		shift = 1,
		mask = 1
	},
	shift = 2,
	mask = 7
}
local map_ext = setmetatable({
	[0] = "cmp_YLRR",
	nil,
	nil,
	nil,
	"twARR",
	nil,
	nil,
	nil,
	"subfcRRR.",
	"mulhduRRR.",
	"addcRRR.",
	"mulhwuRRR.",
	nil,
	nil,
	nil,
	"iselltRRR",
	nil,
	nil,
	nil,
	[144] = {
		[0] = "mtcrfRZ~",
		"mtocrfRZ~",
		shift = 20,
		mask = 1
	},
	{
		[0] = "mfcrR",
		"mfocrfRZ",
		shift = 20,
		mask = 1
	},
	"lwarxRR0R",
	"ldxRR0R",
	nil,
	"lwzxRR0R",
	"slwRR~R.",
	nil,
	"cntlzwRR~",
	"sldRR~R.",
	"andRR~R.",
	nil,
	nil,
	nil,
	"cmpl_YLRR",
	[232] = "subfmeRR.",
	[824] = "srawiRR~A.",
	[233] = "mulldRRR.",
	[149] = "stdxRR0R",
	[181] = "stduxRRR",
	[552] = "subfoRRR.",
	[86] = "dcbf-R0R",
	[235] = "mullwRRR.",
	[119] = "lbzuxRRR",
	[341] = "lwaxRR0R",
	[87] = "lbzxRR0R",
	[343] = "lhaxRR0R",
	mask = 1023,
	[747] = "mullwoRRR.",
	[84] = "ldarxRR0R",
	[745] = "mulldoRRR.",
	[136] = "subfeRRR.",
	[854] = "eieio",
	[215] = "stbxRR0R",
	[457] = "divduRRR.",
	[616] = "negoRR.",
	[459] = "divwuRRR.",
	[200] = "subfzeRR.",
	[438] = "ecowxRR0R",
	[75] = "mulhwRRR.",
	[470] = "dcbi-RR",
	[758] = "dcba-RR",
	[631] = "lfduxFRR",
	[154] = "prtywRR~",
	[58] = "cntlzdRR~",
	[53] = "lduxRRR",
	[60] = "andcRR~R.",
	[73] = "mulhdRRR.",
	[124] = "nor|notRR~R=.",
	[104] = "negRR.",
	[284] = "eqvRR~R.",
	[316] = "xorRR~R.",
	[650] = "addeoRRR.",
	[54] = "dcbst-R0R",
	[412] = "orcRR~R.",
	[79] = "iseleqRRR",
	[439] = "sthuxRRR",
	[310] = "eciwxRR0R",
	[311] = "lhzuxRRR",
	[660] = "stdbrxRR0R",
	[476] = "nandRR~R.",
	[55] = "lwzuxRRR",
	[532] = "ldbrxRR0R",
	[444] = "or|mrRR~R=.",
	[918] = "sthbrxRR0R",
	[214] = "stdcxRR0R.",
	[597] = "lswiRR0A",
	[150] = "stwcxRR0R.",
	[661] = "stswxRR0R",
	[151] = "stwxRR0R",
	[662] = "stwbrxRR0R",
	[790] = "lhbrxRR0R",
	[533] = "lswxRR0R",
	[535] = "lfsxFR0R",
	[695] = "stfsuxFRR",
	[279] = "lhzxRR0R",
	[278] = "dcbt-R0R",
	[648] = "subfeoRRR.",
	[663] = "stfsxFR0R",
	[599] = "lfdxFR0R",
	[202] = "addzeRR.",
	[727] = "stfdxFR0R",
	[759] = "stfduxFR0R",
	[567] = "lfsuxFRR",
	[969] = "divduoRRR.",
	[971] = "divwouRRR.",
	[712] = "subfzeoRR.",
	[714] = "addzeoRR.",
	[725] = "stswiRR0A",
	[407] = "sthxRR0R",
	[68] = "tdARR",
	[855] = "lfiwaxFR0R",
	[983] = "stfiwxFR0R",
	[986] = "extswRR~.",
	[792] = "srawRR~R.",
	[982] = "icbi-R0R",
	[183] = "stwuxRRR",
	[539] = "srdRR~R.",
	[138] = "addeRRR.",
	[534] = "lwbrxRR0R",
	[1001] = "divdoRRR.",
	[1003] = "divwoRRR.",
	[744] = "subfmeoRR.",
	[746] = "addmeoRR.",
	[266] = "addRRR.",
	[522] = "addcoRRR.",
	[520] = "subfcoRRR.",
	[827] = "sradiRR~H.",
	[122] = "popcntbRR~",
	[512] = "mcrxrX",
	[186] = "prtydRR~",
	[1014] = "dcbz-R0R",
	[508] = "cmpbRR~R",
	[922] = "extshRR~.",
	[954] = "extsbRR~.",
	[536] = "srwRR~R.",
	[826] = "sradiRR~H.",
	[778] = "addoRRR.",
	[375] = "lhauxRRR",
	[47] = "iselgtRRR",
	[373] = "lwauxRRR",
	[794] = "sradRR~R.",
	[40] = "subfRRR.",
	[247] = "stbuxRRR",
	[491] = "divwRRR.",
	[246] = "dcbtst-R0R",
	[489] = "divdRRR.",
	[234] = "addmeRR.",
	shift = 1,
	[371] = {
		[424] = "mftbuR",
		[392] = "mftbR",
		shift = 11,
		mask = 1023
	},
	[339] = {
		[32] = "mferR",
		[16] = "mfspefscrR",
		[256] = "mflrR",
		mask = 1023,
		[288] = "mfctrR",
		shift = 11
	},
	[467] = {
		[32] = "mtxerR",
		[16] = "mtspefscrR",
		[256] = "mtlrR",
		mask = 1023,
		[288] = "mtctrR",
		shift = 11
	},
	[598] = {
		[0] = "sync",
		"lwsync",
		"ptesync",
		shift = 21,
		mask = 3
	}
}, {
	__index = function(t, x)
		if band(x, 31) == 15 then
			return "iselRRRC"
		end
	end
})
local map_ld = {
	[0] = "ldRRE",
	"lduRRE",
	"lwaRRE",
	shift = 0,
	mask = 3
}
local map_std = {
	[0] = "stdRRE",
	"stduRRE",
	shift = 0,
	mask = 3
}
local map_fps = {
	{
		[0] = false,
		false,
		"fdivsFFF.",
		false,
		"fsubsFFF.",
		"faddsFFF.",
		"fsqrtsF-F.",
		false,
		"fresF-F.",
		"fmulsFF-F.",
		"frsqrtesF-F.",
		false,
		"fmsubsFFFF~.",
		"fmaddsFFFF~.",
		"fnmsubsFFFF~.",
		"fnmaddsFFFF~.",
		shift = 1,
		mask = 15
	},
	shift = 5,
	mask = 1
}
local map_fpd = {
	[0] = {
		[0] = "fcmpuXFF",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"fcpsgnFFF.",
		nil,
		nil,
		nil,
		"frspF-F.",
		nil,
		"fctiwF-F.",
		"fctiwzF-F.",
		[38] = "mtfsb1A.",
		[264] = "fabsF-F.",
		[711] = "mtfsfZF.",
		[583] = "mffsF.",
		[40] = "fnegF-F.",
		[846] = "fcfidF-F.",
		[815] = "fctidzF-F.",
		[70] = "mtfsb0A.",
		[32] = "fcmpoXFF",
		[392] = "frinF-F.",
		[424] = "frizF-F.",
		mask = 1023,
		[456] = "fripF-F.",
		[488] = "frimF-F.",
		[814] = "fctidF-F.",
		[136] = "fnabsF-F.",
		[64] = "mcrfsXX",
		[134] = "mtfsfiA>>-A>",
		[72] = "fmrF-F.",
		shift = 1
	},
	{
		[0] = false,
		false,
		"fdivFFF.",
		false,
		"fsubFFF.",
		"faddFFF.",
		"fsqrtF-F.",
		"fselFFFF~.",
		"freF-F.",
		"fmulFF-F.",
		"frsqrteF-F.",
		false,
		"fmsubFFFF~.",
		"fmaddFFFF~.",
		"fnmsubFFFF~.",
		"fnmaddFFFF~.",
		shift = 1,
		mask = 15
	},
	shift = 5,
	mask = 1
}
local map_spe = {
	[765] = "efdtstltYRR",
	[759] = "efdctsfR-R",
	[725] = "efsctsiR-R",
	[669] = "evfststltYRR",
	[727] = "efsctsfR-R",
	[1219] = "evsubfssiaawRR",
	[1453] = "evmhogsmianRRR",
	[1039] = "evmhosmfRRR",
	[1281] = "evmhessiaawRRR",
	[1068] = "evmhoumiaRRR",
	[785] = "evlwheRR4",
	[1036] = "evmhoumiRRR",
	[766] = "efdtsteqYRR",
	[754] = "efdcfufR-R",
	[1421] = "evmhosmianwRRR",
	[756] = "efdctuiR-R",
	[1413] = "evmhossianwRRR",
	[542] = "evnandRRR",
	[544] = "evsrwuRRR",
	[724] = "efsctuiR-R",
	[1035] = "evmhesmfRRR",
	[1031] = "evmhossfRRR",
	[560] = "evcmpgtuYRR",
	[514] = "evaddiwRAR~",
	[522] = "evextsbRR",
	[668] = "evfststgtYRR",
	[666] = "evfsctsizR-R",
	[660] = "evfsctuiR-R",
	[633] = "evselRRRW",
	[1222] = "evdivwsRRR",
	[637] = "evselRRRW",
	[521] = "evnegRR",
	[526] = "evcntlswRR",
	[640] = "evfsaddRRR",
	[525] = "evcntlzwRR",
	[639] = "evselRRRW",
	[644] = "evfsabsRR",
	[652] = "evfscmpgtYRR",
	[648] = "evfsmulRRR",
	[1324] = "evmhogumiaaRRR",
	[1037] = "evmhosmiRRR",
	[635] = "evselRRRW",
	[656] = "evfscfuiR-R",
	[658] = "evfscfufR-R",
	[1284] = "evmhousiaawRRR",
	[719] = "efscfdR-R",
	[664] = "evfsctuizR-R",
	[1292] = "evmhoumiaawRRR",
	[1069] = "evmhosmiaRRR",
	[562] = "evcmpltuYRR",
	[537] = "eveqvRRR",
	[554] = "evrlwiRRA",
	[552] = "evrlwRRR",
	[546] = "evsrwiuRRA",
	[713] = "efsdivRRR",
	[716] = "efscmpgtYRR",
	[1101] = "evmwhsmiRRR",
	[721] = "efscfsiR-R",
	[722] = "efscfufR-R",
	[738] = "efdcfuidR-R",
	[752] = "efdcfuiR-R",
	[732] = "efststgtYRR",
	[536] = "evnor|evnotRRR=",
	[535] = "evor|evmrRRR=",
	[1133] = "evmwhsmiaRRR",
	[708] = "efsabsRR",
	[530] = "evandcRRR",
	[704] = "efsaddRRR",
	[529] = "evandRRR",
	[564] = "evcmpeqYRR",
	[1452] = "evmhogumianRRR",
	[712] = "efsmulRRR",
	[527] = "brincRRR",
	[556] = "evmergehiRRR",
	[1345] = "evmwlssiaawRRR",
	[720] = "efscfuiR-R",
	[518] = "evsubiwRAR~",
	[548] = "evslwRRR",
	[1420] = "evmhoumianwRRR",
	[728] = "efsctuizR-R",
	[1412] = "evmhousianwRRR",
	[740] = "efdabsRR",
	[516] = "evsubwRRR~",
	[736] = "efdaddRRR",
	[748] = "efdcmpgtYRR",
	[744] = "efdmulRRR",
	[524] = "evrndwRR",
	[520] = "evabsRR",
	[764] = "efdtstgtYRR",
	[512] = "evaddwRRR",
	[760] = "efdctuizR-R",
	[773] = "evldhRR8",
	[769] = "evlddRR8",
	[781] = "evlhhousplatRR2",
	[1323] = "evmhegsmfaaRRR",
	[777] = "evlhhesplatRR2",
	[789] = "evlwhouRR4",
	[1283] = "evmhessfaawRRR",
	[797] = "evlwhsplatRR4",
	[1291] = "evmhesmfaawRRR",
	[793] = "evlwwsplatRR4",
	[805] = "evstdhRR8",
	[801] = "evstddRR8",
	[1100] = "evmwhumiRRR",
	[821] = "evstwhoRR4",
	[817] = "evstwheRR4",
	[829] = "evstwwoRR4",
	[1132] = "evmwhumiaRRR",
	[825] = "evstwweRR4",
	[1363] = "evmwssfaaRRR",
	[1371] = "evmwsmfaaRRR",
	[1451] = "evmhegsmfanRRR",
	[1419] = "evmhesmfanwRRR",
	[1411] = "evmhessfanwRRR",
	[632] = "evselRRR",
	[1220] = "evmraRR",
	[636] = "evselRRRW",
	[1499] = "evmwsmfanRRR",
	[1491] = "evmwssfanRRR",
	[659] = "evfscfsfR-R",
	[1027] = "evmhessfRRR",
	[663] = "evfsctsfR-R",
	[1067] = "evmhesmfaRRR",
	[1059] = "evmhessfaRRR",
	[1115] = "evmwsmfRRR",
	[1107] = "evmwssfRRR",
	[1147] = "evmwsmfaRRR",
	[1139] = "evmwssfaRRR",
	[563] = "evcmpltsYRR",
	[559] = "evmergelohiRRR",
	[555] = "evsplatfiRS",
	[723] = "efscfsfR-R",
	[547] = "evsrwisRRA",
	[539] = "evorcRRR",
	[739] = "efdcfsidR-R",
	[751] = "efdcfsR-R",
	[747] = "efdctsidzR-R",
	[523] = "evextshRR",
	[755] = "efdcfsfR-R",
	[1227] = "evsubfsmiaawRR",
	[772] = "evldhxRR0R",
	[768] = "evlddxRR0R",
	[780] = "evlhhousplatxRR0R",
	[1321] = "evmhegsmiaaRRR",
	[776] = "evlhhesplatxRR0R",
	[788] = "evlwhouxRR0R",
	[784] = "evlwhexRR0R",
	[796] = "evlwhsplatxRR0R",
	[1289] = "evmhesmiaawRRR",
	[792] = "evlwwsplatxRR0R",
	[804] = "evstdhxRR0R",
	[800] = "evstddxRR0R",
	[820] = "evstwhoxRR0R",
	[816] = "evstwhexRR0R",
	shift = 0,
	[828] = "evstwwoxRR0R",
	[1353] = "evmwlsmiaawRRR",
	[824] = "evstwwexRR0R",
	[1369] = "evmwsmiaaRRR",
	[1449] = "evmhegsmianRRR",
	[1417] = "evmhesmianwRRR",
	[1409] = "evmhessianwRRR",
	mask = 2047,
	[1218] = "evsubfusiaawRR",
	[1481] = "evmwlsmianwRRR",
	[1226] = "evsubfumiaawRR",
	[1473] = "evmwlssianwRRR",
	[1497] = "evmwsmianRRR",
	[646] = "evfsnegRR",
	[654] = "evfscmpeqYRR",
	[1320] = "evmhegumiaaRRR",
	[1033] = "evmhesmiRRR",
	[662] = "evfsctufR-R",
	[1280] = "evmheusiaawRRR",
	[670] = "evfststeqYRR",
	[1288] = "evmheumiaawRRR",
	[1065] = "evmhesmiaRRR",
	[1113] = "evmwsmiRRR",
	[1145] = "evmwsmiaRRR",
	[1344] = "evmwlusiaawRRR",
	[1352] = "evmwlumiaawRRR",
	[710] = "efsnegRR",
	[1368] = "evmwumiaaRRR",
	[1448] = "evmhegumianRRR",
	[718] = "efscmpeqYRR",
	[558] = "evmergehiloRRR",
	[726] = "efsctufR-R",
	[550] = "evslwiRRA",
	[1416] = "evmheumianwRRR",
	[734] = "efststeqYRR",
	[1408] = "evmheusianwRRR",
	[730] = "efsctsizR-R",
	[742] = "efdnegRR",
	[534] = "evxorRRR",
	[750] = "efdcmpeqYRR",
	[746] = "efdctuidzR-R",
	[758] = "efdctufR-R",
	[1217] = "evaddssiaawRR",
	[1480] = "evmwlumianwRRR",
	[1225] = "evaddsmiaawRR",
	[1472] = "evmwlusianwRRR",
	[762] = "efdctsizR-R",
	[1496] = "evmwumianRRR",
	[771] = "evldwRR8",
	[783] = "evlhhossplatRR2",
	[1327] = "evmhogsmfaaRRR",
	[1032] = "evmheumiRRR",
	[791] = "evlwhosRR4",
	[1287] = "evmhossfaawRRR",
	[1295] = "evmhosmfaawRRR",
	[1064] = "evmheumiaRRR",
	[803] = "evstdwRR8",
	[1112] = "evmwumiRRR",
	[1096] = "evmwlumiRRR",
	[1144] = "evmwumiaRRR",
	[1128] = "evmwlumiaRRR",
	[1455] = "evmhogsmfanRRR",
	[1423] = "evmhosmfanwRRR",
	[1415] = "evmhossfanwRRR",
	[1216] = "evaddusiaawRR",
	[634] = "evselRRRW",
	[1224] = "evaddumiaawRR",
	[638] = "evselRRRW",
	[641] = "evfssubRRR",
	[645] = "evfsnabsRR",
	[649] = "evfsdivRRR",
	[653] = "evfscmpltYRR",
	[657] = "evfscfsiR-R",
	[661] = "evfsctsiR-R",
	[1071] = "evmhosmfaRRR",
	[1063] = "evmhossfaRRR",
	[1103] = "evmwhsmfRRR",
	[1095] = "evmwhssfRRR",
	[1135] = "evmwhsmfaRRR",
	[709] = "efsnabsRR",
	[1127] = "evmwhssfaRRR",
	[705] = "efssubRRR",
	[717] = "efscmpltYRR",
	[561] = "evcmpgtsYRR",
	[557] = "evmergeloRRR",
	[553] = "evsplatiRS",
	[733] = "efststltYRR",
	[545] = "evsrwsRRR",
	[741] = "efdnabsRR",
	[737] = "efdsubRRR",
	[749] = "efdcmpltYRR",
	[745] = "efddivRRR",
	[757] = "efdctsiR-R",
	[753] = "efdcfsiR-R",
	[1223] = "evdivwuRRR",
	[770] = "evldwxRR0R",
	[782] = "evlhhossplatxRR0R",
	[1325] = "evmhogsmiaaRRR",
	[790] = "evlwhosxRR0R",
	[1285] = "evmhossiaawRRR",
	[1293] = "evmhosmiaawRRR",
	[802] = "evstdwxRR0R"
}
local map_pri = {
	[0] = false,
	false,
	"tdiARI",
	"twiARI",
	map_spe,
	false,
	false,
	"mulliRRI",
	"subficRRI",
	false,
	"cmpl_iYLRU",
	"cmp_iYLRI",
	"addicRRI",
	"addic.RRI",
	"addi|liRR0I",
	"addis|lisRR0I",
	"b_KBJ",
	"sc",
	"bKJ",
	map_crops,
	"rlwimiRR~AAA.",
	map_rlwinm,
	false,
	"rlwnmRR~RAA.",
	"oriNRR~U",
	"orisRR~U",
	"xoriRR~U",
	"xorisRR~U",
	"andi.RR~U",
	"andis.RR~U",
	map_rld,
	map_ext,
	"lwzRRD",
	"lwzuRRD",
	"lbzRRD",
	"lbzuRRD",
	"stwRRD",
	"stwuRRD",
	"stbRRD",
	"stbuRRD",
	"lhzRRD",
	"lhzuRRD",
	"lhaRRD",
	"lhauRRD",
	"sthRRD",
	"sthuRRD",
	"lmwRRD",
	"stmwRRD",
	"lfsFRD",
	"lfsuFRD",
	"lfdFRD",
	"lfduFRD",
	"stfsFRD",
	"stfsuFRD",
	"stfdFRD",
	"stfduFRD",
	false,
	false,
	map_ld,
	map_fps,
	false,
	false,
	map_std,
	map_fpd
}
local map_gpr = {
	[0] = "r0",
	"sp",
	"r2",
	"r3",
	"r4",
	"r5",
	"r6",
	"r7",
	"r8",
	"r9",
	"r10",
	"r11",
	"r12",
	"r13",
	"r14",
	"r15",
	"r16",
	"r17",
	"r18",
	"r19",
	"r20",
	"r21",
	"r22",
	"r23",
	"r24",
	"r25",
	"r26",
	"r27",
	"r28",
	"r29",
	"r30",
	"r31"
}
local map_cond = {
	[0] = "lt",
	"gt",
	"eq",
	"so",
	"ge",
	"le",
	"ne",
	"ns"
}

local function condfmt(cond)
	if cond <= 3 then
		return map_cond[band(cond, 3)]
	else
		return format("4*cr%d+%s", rshift(cond, 2), map_cond[band(cond, 3)])
	end
end

local function putop(ctx, text, operands)
	local pos = ctx.pos
	local extra = ""

	if ctx.rel then
		local sym = ctx.symtab[ctx.rel]

		if sym then
			extra = "\t->" .. sym
		end
	end

	if ctx.hexdump > 0 then
		ctx.out(format("%08x  %s  %-7s %s%s\n", ctx.addr + pos, tohex(ctx.op), text, concat(operands, ", "), extra))
	else
		ctx.out(format("%08x  %-7s %s%s\n", ctx.addr + pos, text, concat(operands, ", "), extra))
	end

	ctx.pos = pos + 4
end

local function unknown(ctx)
	return putop(ctx, ".long", {
		"0x" .. tohex(ctx.op)
	})
end

local function disass_ins(ctx)
	local pos = ctx.pos
	local b0, b1, b2, b3 = byte(ctx.code, pos + 1, pos + 4)
	local op = bor(lshift(b0, 24), lshift(b1, 16), lshift(b2, 8), b3)
	local operands = {}
	local last
	local rs = 21

	ctx.op = op
	ctx.rel = nil

	local opat = map_pri[rshift(b0, 2)]

	while type(opat) ~= "string" do
		if not opat then
			return unknown(ctx)
		end

		opat = opat[band(rshift(op, opat.shift), opat.mask)]
	end

	local name, pat = match(opat, "^([a-z0-9_.]*)(.*)")
	local altname, pat2 = match(pat, "|([a-z0-9_.]*)(.*)")

	if altname then
		pat = pat2
	end

	for p in gmatch(pat, ".") do
		local x

		if p == "R" then
			x = map_gpr[band(rshift(op, rs), 31)]
			rs = rs - 5
		elseif p == "F" then
			x = "f" .. band(rshift(op, rs), 31)
			rs = rs - 5
		elseif p == "A" then
			x = band(rshift(op, rs), 31)
			rs = rs - 5
		elseif p == "S" then
			x = arshift(lshift(op, 27 - rs), 27)
			rs = rs - 5
		elseif p == "I" then
			x = arshift(lshift(op, 16), 16)
		elseif p == "U" then
			x = band(op, 65535)
		elseif p == "D" or p == "E" then
			local disp = arshift(lshift(op, 16), 16)

			if p == "E" then
				disp = band(disp, -4)
			end

			if last == "r0" then
				last = "0"
			end

			operands[#operands] = format("%d(%s)", disp, last)
		elseif p >= "2" and p <= "8" then
			local disp = band(rshift(op, rs), 31) * p

			if last == "r0" then
				last = "0"
			end

			operands[#operands] = format("%d(%s)", disp, last)
		elseif p == "H" then
			x = band(rshift(op, rs), 31) + lshift(band(op, 2), 4)
			rs = rs - 5
		elseif p == "M" then
			x = band(rshift(op, rs), 31) + band(op, 32)
		elseif p == "C" then
			x = condfmt(band(rshift(op, rs), 31))
			rs = rs - 5
		elseif p == "B" then
			local bo = rshift(op, 21)
			local cond = band(rshift(op, 16), 31)
			local cn = ""

			rs = rs - 10

			if band(bo, 4) == 0 then
				cn = band(bo, 2) == 0 and "dnz" or "dz"

				if band(bo, 16) == 0 then
					cn = cn .. (band(bo, 8) == 0 and "f" or "t")
				end

				if band(bo, 16) == 0 then
					x = condfmt(cond)
				end

				name = name .. (band(bo, 1) == band(rshift(op, 15), 1) and "-" or "+")
			elseif band(bo, 16) == 0 then
				cn = map_cond[band(cond, 3) + (band(bo, 8) == 0 and 4 or 0)]

				if cond > 3 then
					x = "cr" .. rshift(cond, 2)
				end

				name = name .. (band(bo, 1) == band(rshift(op, 15), 1) and "-" or "+")
			end

			name = gsub(name, "_", cn)
		elseif p == "J" then
			x = arshift(lshift(op, 27 - rs), 29 - rs) * 4

			if band(op, 2) == 0 then
				x = ctx.addr + pos + x
			end

			ctx.rel = x
			x = "0x" .. tohex(x)
		elseif p == "K" then
			if band(op, 1) ~= 0 then
				name = name .. "l"
			end

			if band(op, 2) ~= 0 then
				name = name .. "a"
			end
		elseif p == "X" or p == "Y" then
			x = band(rshift(op, rs + 2), 7)
			x = (x ~= 0 or p ~= "Y" or nil) and "cr" .. x
			rs = rs - 5
		elseif p == "W" then
			x = "cr" .. band(op, 7)
		elseif p == "Z" then
			x = band(rshift(op, rs - 4), 255)
			rs = rs - 10
		elseif p == ">" then
			operands[#operands] = rshift(operands[#operands], 1)
		elseif p == "0" then
			if last == "r0" then
				operands[#operands] = nil

				if altname then
					name = altname
				end
			end
		elseif p == "L" then
			name = gsub(name, "_", band(op, 2097152) ~= 0 and "d" or "w")
		elseif p == "." then
			if band(op, 1) == 1 then
				name = name .. "."
			end
		elseif p == "N" then
			if op == 1610612736 then
				name = "nop"

				break
			end
		elseif p == "~" then
			local n = #operands

			operands[n - 1], operands[n] = operands[n], operands[n - 1]
		elseif p == "=" then
			local n = #operands

			if last == operands[n - 1] then
				operands[n] = nil
				name = altname
			end
		elseif p == "%" then
			local n = #operands

			if last == operands[n - 1] and last == operands[n - 2] then
				operands[n] = nil
				operands[n - 1] = nil
				name = altname
			end
		elseif p == "-" then
			rs = rs - 5
		else
			assert(false)
		end

		if x then
			operands[#operands + 1] = x
			last = x
		end
	end

	return putop(ctx, name, operands)
end

local function disass_block(ctx, ofs, len)
	ofs = ofs or 0

	if len then
		if not (ofs + len) then
			local stop = #ctx.code

			stop = stop - stop % 4
			ctx.pos = ofs - ofs % 4
			ctx.rel = nil

			while stop > ctx.pos do
				disass_ins(ctx)
			end
		end
	end
end

local function create(code, addr, out)
	local ctx = {}

	ctx.code = code
	ctx.addr = addr or 0
	ctx.out = out or io.write
	ctx.symtab = {}
	ctx.disass = disass_block
	ctx.hexdump = 8

	return ctx
end

local function disass(code, addr, out)
	create(code, addr, out):disass()
end

local function regname(r)
	if r < 32 then
		return map_gpr[r]
	end

	return "f" .. r - 32
end

return {
	create = create,
	disass = disass,
	regname = regname
}
