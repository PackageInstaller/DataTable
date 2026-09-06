-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/view/RunetipView.lua

module("logic.extensions.rune.view.RunetipView", package.seeall)

local RunetipView = class("RunetipView", ViewComponent)

function RunetipView:ctor()
	RunetipView.super.ctor(self)
end

function RunetipView:buildUI()
	RunetipView.super.buildUI(self)

	self._Nego_Content = goutil.findChild(self.mainGO, "Nego_Content")
	self._adjustPosition = self._Nego_Content:GetComponent("UIAdjustPosition")
	self._customInput = UICustomInput.Get(self._Nego_Content)
	self.imgBg = goutil.findChildComponent(self._Nego_Content, "txtStarName", "UIChangeGroup")
	self.equipItemGo = self:getGo("Nego_Content/equipItemGo")
	self.attrItemPos = self:getGo("Nego_Content/attrItemPos")
	self.attrItem = self:getGo("Nego_Content/attrItem")
	self.txtStarName = self:getTxt("Nego_Content/txtStarName")
	self.powerTxt = self:getTxt("Nego_Content/powerTxt")
	self.txtType = self:getTxt("Nego_Content/txtType")

	GameUtil.SetActive(self.attrItem, false)
end

function RunetipView:bindEvents()
	RunetipView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function RunetipView:unbindEvents()
	RunetipView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function RunetipView:destroyUI()
	RunetipView.super.destroyUI(self)
end

function RunetipView:onEnter()
	RunetipView.super.onEnter(self)

	local data = self._viewPresentor._openParam[1]
	local pos = self._viewPresentor._openParam[2]

	if not self._viewPresentor._openParam[3] then
		local sizeDelta = {
			0,
			0
		}

		if pos then
			GameUtil.SetActive(self.mainGO, false)
			settimer(0.1, function()
				GameUtil.SetActive(self.mainGO, true)
				Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
				self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
			end, nil, false)
		else
			Framework.TransformUtil.SetLocalPos(self._Nego_Content.transform, 0, 0, 0)
		end

		self.imgBg:SetState(data:getQuality() - 1)
		MaterialMgr.setCellByData(MatType.Rune, data, self.equipItemGo)

		self.txtStarName.text = data:getName()
		self.powerTxt.text = data:getZDL()
		self.txtType.text = lang("类型：") .. data:getTypeName()

		goutil.clearChildren(self.attrItemPos)

		local list = GameUtil.propToList({
			data:getProp()
		})

		for i, v in ipairs(list) do
			self:showItem(i, v.name, v.value)
		end
	end
end

function RunetipView:showItem(index, name, value)
	local cell = goutil.clone(self.attrItem, "attrItem" .. index)

	goutil.addChildToParent(cell, self.attrItemPos)
	GameUtil.SetActive(cell, true)

	local itemBgGo = goutil.findChild(cell, "itemBgGo")
	local attrIconSpt = goutil.findChildComponent(cell, "iconSpt", "UIImageSpriteChange")
	local qhNameTxt = goutil.findChildTextComponent(cell, "countTxt")
	local qhNowCountTxt = goutil.findChildTextComponent(cell, "txtNum")

	GameUtil.SetActive(itemBgGo, index % 2 == 0)

	local idx = table.indexof(GameEnum.AttrTypeName, name)

	attrIconSpt:SetState(idx - 1)

	qhNameTxt.text = name
	qhNowCountTxt.text = GameUtil.getValueOrPercent(value)
end

function RunetipView:onEnterFinished()
	RunetipView.super.onEnterFinished(self)
end

function RunetipView:onExit()
	RunetipView.super.onExit(self)
end

function RunetipView:onExitFinished()
	RunetipView.super.onExitFinished(self)
end

function RunetipView:_onCustomInputCallback(hover)
	CommonTipsMgr.instance:doWillClose(self, hover)
end

return RunetipView
