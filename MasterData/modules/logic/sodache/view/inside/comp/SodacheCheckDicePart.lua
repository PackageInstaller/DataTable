-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheCheckDicePart.lua

module("modules.logic.sodache.view.inside.comp.SodacheCheckDicePart", package.seeall)

local SodacheCheckDicePart = class("SodacheCheckDicePart", LuaCompBase)

function SodacheCheckDicePart:init(go)
	self._gosuccessdiceitem = gohelper.findChild(go, "#go_success/dices/#go_item") or gohelper.findChild(go, "success/dices/#go_item")
	self._gobigsuccess = gohelper.findChild(go, "#go_bigsuccess") or gohelper.findChild(go, "bigsuccess")
	self._gobigsuccessdiceitem = gohelper.findChild(self._gobigsuccess, "dices/#go_item")
	self._goup = gohelper.findChild(self._gobigsuccess, "dicesMore/Up")
	self._godown = gohelper.findChild(self._gobigsuccess, "dicesMore/Down")
end

function SodacheCheckDicePart:updateDices(verifyCond)
	local arr = string.split(verifyCond, "|") or {}

	if arr[2] then
		arr[2] = arr[1] .. "&" .. arr[2]
	end

	if #arr <= 0 then
		return
	end

	gohelper.setActive(self._gosuccessdiceitem, false)
	gohelper.setActive(self._gobigsuccessdiceitem, false)
	self:setDices(arr[1], self._gosuccessdiceitem)
	self:setDices(arr[2], self._gobigsuccessdiceitem, self._goup, self._godown)
	gohelper.setActive(self._gobigsuccess, arr[2])
end

function SodacheCheckDicePart:setDices(str, itemGo, upGo, downGo)
	if string.nilorempty(str) then
		return
	end

	local arr = GameUtil.splitString2(str, true, "&", ":") or {}
	local datas = {}

	for i, v in ipairs(arr) do
		for count = 1, v[1] do
			table.insert(datas, v[2])
		end
	end

	if #datas > 5 and upGo and downGo then
		local data1 = {
			unpack(datas, 1, 5)
		}
		local data2 = {
			unpack(datas, 6)
		}

		gohelper.CreateObjList(self, self._createDices, data1, upGo, itemGo)
		gohelper.CreateObjList(self, self._createDices, data2, downGo, itemGo)
	else
		gohelper.CreateObjList(self, self._createDices, datas, nil, itemGo)
	end
end

function SodacheCheckDicePart:_createDices(obj, data, index)
	local icon = gohelper.findChildImage(obj, "#image_icon")

	UISpriteSetMgr.instance:setSodache2Sprite(icon, "sodache_touzi_" .. data)
end

return SodacheCheckDicePart
