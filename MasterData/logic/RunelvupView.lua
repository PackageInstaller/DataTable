-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/view/RunelvupView.lua

module("logic.extensions.rune.view.RunelvupView", package.seeall)

local RunelvupView = class("RunelvupView", ViewComponent)

function RunelvupView:ctor()
	RunelvupView.super.ctor(self)
end

function RunelvupView:buildUI()
	RunelvupView.super.buildUI(self)

	self.bg = self:getGo("bg")
	self.txt_left_lv = self:getTxt("Level/txt_left_lv")
	self.txt_right_lv = self:getTxt("Level/txt_right_lv")
	self.txtItemName = self:getTxt("txtItemName")
	self.item = self:getGo("item")
	self.attr = self:getGo("attr")

	GameUtil.SetActive(self.attr, false)

	self.qhShowTran = self:getGo("qhShowTran")
end

function RunelvupView:bindEvents()
	RunelvupView.super.bindEvents(self)
	GameUtil.addClickHandler(self.bg, self.close, self)
end

function RunelvupView:unbindEvents()
	RunelvupView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.bg)
end

function RunelvupView:destroyUI()
	RunelvupView.super.destroyUI(self)
end

function RunelvupView:onEnter()
	RunelvupView.super.onEnter(self)

	local param = self:getOpenParam()

	self.currRuneId = checknumber(param[1])
	self.lastLv = checknumber(param[2])
	self.nextLv = checknumber(param[3])

	local mo = RuneModel.instance:getItemData(self.currRuneId)

	MaterialMgr.setCellByGId(MatType.Rune, self.currRuneId, self.item)

	self.txtItemName.text = mo:getName()
	self.txt_left_lv.text = "Lv." .. self.lastLv
	self.txt_right_lv.text = "Lv." .. self.nextLv

	goutil.clearChildren(self.qhShowTran)

	local curPropStr = RuneConfig.instance:getRuneLvlCfg(mo:getDefineId(), self.lastLv).propertyApp
	local cfg = RuneConfig.instance:getRuneLvlCfg(mo:getDefineId(), self.nextLv)
	local curArr = GameUtil.propToList({
		curPropStr
	})
	local nextArr = GameUtil.propToList({
		cfg.propertyApp
	})

	for k, v in pairs(nextArr) do
		local cur = 0

		for kk, vv in pairs(curArr) do
			if vv.name == v.name then
				cur = vv.value

				break
			end
		end

		self:showItem(v.name, cur, v.value)
	end
end

function RunelvupView:showItem(name, value, next)
	local cell = goutil.clone(self.attr, "qhItem")

	goutil.addChildToParent(cell, self.qhShowTran)
	GameUtil.SetActive(cell, true)

	local qhNameTxt = goutil.findChildTextComponent(cell, "cell/title")
	local qhNowCountTxt = goutil.findChildTextComponent(cell, "cell/txt_left_lv")
	local qhNextCountTxt = goutil.findChildTextComponent(cell, "cell/txt_right_lv")
	local idx = table.indexof(GameEnum.AttrTypeName, name)

	qhNameTxt.text = name
	qhNowCountTxt.text = value
	qhNowCountTxt.text = GameUtil.getValueOrPercent(value)
	qhNextCountTxt.text = GameUtil.getValueOrPercent(next)
end

function RunelvupView:onEnterFinished()
	RunelvupView.super.onEnterFinished(self)
end

function RunelvupView:onExit()
	RunelvupView.super.onExit(self)
end

function RunelvupView:onExitFinished()
	RunelvupView.super.onExitFinished(self)
	RuneController.instance:showRuneCI()
end

return RunelvupView
