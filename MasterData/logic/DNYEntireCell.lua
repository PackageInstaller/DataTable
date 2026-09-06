-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinenuoyachallenge/view/DNYEntireCell.lua

module("logic.extensions.divinenuoyachallenge.view.DNYEntireCell", package.seeall)

local DNYEntireCell = class("DNYEntireCell")

function DNYEntireCell:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._txtName = goutil.findChildTextComponent(go, "node/txtName")
	self._selectGo = goutil.findChild(go, "node/select")
	self._tableviewGo = goutil.findChild(go, "node/tableview")
	self._tablecellGo = goutil.findChild(go, "node/tablecell")
	self._scrollList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClick = Framework.ButtonAdapter.GetFrom(go, "node")

	self._btnClick:AddClickListener(self._onClick, self)

	self._powerPetMo = FightingPowerPetMo.New()
end

function DNYEntireCell:init(data)
	self._data = data

	local list = {}

	for k, v in pairs(data.petCfgs) do
		table.insert(list, v)
	end

	self._scrollList:reloadData(list)

	self._txtName.text = string.format("助战-第%d阵", data.index)

	goutil.setActive(self._selectGo, data.isSelect)
end

function DNYEntireCell:clear()
	self._scrollList:dispose()
end

function DNYEntireCell:_onClick()
	if not self._data.isSelect then
		DivineNuoYaChallengeController.instance:localNotify(DivineNuoYaChallengeController.SelectEvent, self._data.index)
	end
end

function DNYEntireCell:_updateCell(view, cell, data, tag)
	local node = goutil.findChild(cell, "node")

	self._powerPetMo:fromChallengeCreepCo(data)

	local bagPetMo = self._powerPetMo:toBaseBagPetMo()
	local proxy = MaterialMgr.setCellByMo(bagPetMo, node)

	proxy.binder:setAutoTips(false)
	proxy:setCallBack(function()
		CommonTipsMgr.instance:showPetTips(bagPetMo)
	end)
end

function DNYEntireCell:_clearCell(cell)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.resetAll(node)
end

return DNYEntireCell
