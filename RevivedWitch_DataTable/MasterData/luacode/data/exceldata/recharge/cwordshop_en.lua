-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/recharge/cwordshop_en.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cwordshop_en = {}
cwordshop_en.Data = {
[1100001] = {id = 1100001, text = "Selected Pack"}
, 
[1100002] = {id = 1100002, text = "Beginner\'s Selection"}
, 
[1100003] = {id = 1100003, text = "Limited Pack"}
, 
[1100004] = {id = 1100004, text = "Top Up"}
, 
[1100005] = {id = 1100005, text = "Packs"}
, 
[1100006] = {id = 1100006, text = "Permanent Costume"}
, 
[1100007] = {id = 1100007, text = "White Petal"}
, 
[1100008] = {id = 1100008, text = "Golden Petal"}
, 
[1100009] = {id = 1100009, text = "Friendship Points"}
, 
[1100010] = {id = 1100010, text = "Spring Festival Limited Offer"}
, 
[1100011] = {id = 1100011, text = "Mintage"}
, 
[1100012] = {id = 1100012, text = "Mintage"}
, 
[1100013] = {id = 1100013, text = "Furniture Shop"}
, 
[1100014] = {id = 1100014, text = "Hot Items"}
, 
[1100015] = {id = 1100015, text = "Diamond"}
, 
[1100016] = {id = 1100016, text = "Packs"}
, 
[1100017] = {id = 1100017, text = "Costume"}
, 
[1100018] = {id = 1100018, text = "Groceries"}
, 
[1100019] = {id = 1100019, text = "Spring Festival Limited Offer"}
, 
[1100020] = {id = 1100020, text = "Dreamland"}
, 
[1100021] = {id = 1100021, text = "Dreamland"}
, 
[1100022] = {id = 1100022, text = "Monthly Card"}
, 
[1100023] = {id = 1100023, text = "First Top-up Gift"}
, 
[1100024] = {id = 1100024, text = "Limited Pack"}
, 
[1100025] = {id = 1100025, text = "Limited Costume"}
, 
[1100026] = {id = 1100026, text = "Purchased"}
, 
[1100027] = {id = 1100027, text = "Furniture"}
, 
[1100028] = {id = 1100028, text = "Events"}
, 
[1100029] = {id = 1100029, text = "Intangible Barrier"}
, 
[1100030] = {id = 1100030, text = "Legendary Equipment Box"}
, 
[1100031] = {id = 1100031, text = "Legendary Destroyer Equipment Box"}
, 
[1100032] = {id = 1100032, text = "Equipment Box: Legendary Equipment"}
, 
[1100033] = {id = 1100033, text = "Weapon"}
, 
[1100034] = {id = 1100034, text = "Armor"}
, 
[1100035] = {id = 1100035, text = "Accessory"}
, 
[1100036] = {id = 1100036, text = "30% chance"}
, 
[1100037] = {id = 1100037, text = "Limited Equipment"}
, 
[1100038] = {id = 1100038, text = "You may get a Legendary Equipment while purchasing Equipment Boxes"}
, 
[1100039] = {id = 1100039, text = "Chronospace Breach"}
, 
[1100040] = {id = 1100040, text = "New Arrival"}
, 
[1100041] = {id = 1100041, text = "Comfort"}
, 
[1100042] = {id = 1100042, text = "Price"}
, 
[1100043] = {id = 1100043, text = "Are you sure to redeem $parameter3$ $parameter4$ with $parameter1$ $parameter2$?"}
, 
[1100044] = {id = 1100044, text = "Redeem $parameter1$"}
, 
[1100045] = {id = 1100045, text = "Insufficient $parameter1$"}
, 
[1100046] = {id = 1100046, text = "You need $parameter1$ $parameter2$. Please redeem with $parameter3$ $parameter4$."}
, 
[1100047] = {id = 1100047, text = "Are you sure to redeem $parameter3$ $parameter4$ with $parameter1$ $parameter2$?"}
, 
[1100048] = {id = 1100048, text = "-$parameter1$"}
, 
[1100049] = {id = 1100049, text = "Insufficient $parameter1$ for $parameter2$. Purchase $parameter3$ in the Shop?"}
, 
[1100050] = {id = 1100050, text = "Growth Pack"}
, 
[1100051] = {id = 1100051, text = "Legendary Weapon"}
, 
[1100052] = {id = 1100052, text = "Legendary Armor"}
, 
[1100053] = {id = 1100053, text = "Legendary Accessory"}
, 
[1100054] = {id = 1100054, text = "Gold Equipment"}
, 
[1100055] = {id = 1100055, text = "50% chance"}
, 
[1100056] = {id = 1100056, text = "10% chance"}
, 
[1100057] = {id = 1100057, text = ""}
, 
[1100058] = {id = 1100058, text = ""}
, 
[1100059] = {id = 1100059, text = ""}
, 
[1100060] = {id = 1100060, text = ""}
, 
[1100061] = {id = 1100061, text = ""}
, 
[1100062] = {id = 1100062, text = ""}
, 
[1100063] = {id = 1100063, text = ""}
, 
[1100064] = {id = 1100064, text = ""}
, 
[1100065] = {id = 1100065, text = ""}
, 
[1100066] = {id = 1100066, text = ""}
, 
[1100067] = {id = 1100067, text = ""}
, 
[1100068] = {id = 1100068, text = ""}
, 
[1100069] = {id = 1100069, text = ""}
, 
[1100070] = {id = 1100070, text = ""}
}
cwordshop_en.AllIds = {1100001, 1100002, 1100003, 1100004, 1100005, 1100006, 1100007, 1100008, 1100009, 1100010, 1100011, 1100012, 1100013, 1100014, 1100015, 1100016, 1100017, 1100018, 1100019, 1100020, 1100021, 1100022, 1100023, 1100024, 1100025, 1100026, 1100027, 1100028, 1100029, 1100030, 1100031, 1100032, 1100033, 1100034, 1100035, 1100036, 1100037, 1100038, 1100039, 1100040, 1100041, 1100042, 1100043, 1100044, 1100045, 1100046, 1100047, 1100048, 1100049, 1100050, 1100051, 1100052, 1100053, 1100054, 1100055, 1100056, 1100057, 1100058, 1100059, 1100060, 1100061, 1100062, 1100063, 1100064, 1100065, 1100066, 1100067, 1100068, 1100069, 1100070}
return cwordshop_en

