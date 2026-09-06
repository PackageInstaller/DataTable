-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestEquipTipView.lua

module("logic.extensions.martialcontest.view.MartialContestEquipTipView", package.seeall)

local MartialContestEquipTipView = class("MartialContestEquipTipView", ViewComponent)

function MartialContestEquipTipView:ctor()
	MartialContestEquipTipView.super.ctor(self)
end

function MartialContestEquipTipView:destroyUI()
	MartialContestEquipTipView.super.destroyUI(self)
end

function MartialContestEquipTipView:onExitFinished()
	MartialContestEquipTipView.super.onExitFinished(self)
end

function MartialContestEquipTipView:onEnterFinished()
	MartialContestEquipTipView.super.onEnterFinished(self)
end

function MartialContestEquipTipView:unbindEvents()
	MartialContestEquipTipView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function MartialContestEquipTipView:bindEvents()
	MartialContestEquipTipView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function MartialContestEquipTipView:_onCustomInputCallback(hover)
	CommonTipsMgr.instance:doWillClose(self, hover)
end

function MartialContestEquipTipView:onExit()
	MartialContestEquipTipView.super.onExit(self)
	MaterialMgr.resetAll(self._imgIcon)
end

function MartialContestEquipTipView:buildUI()
	MartialContestEquipTipView.super.buildUI(self)

	self.content = self:getGo("Nego_Content")

	local top = goutil.findChild(self.content, "Nego_Top")
	local bottom = goutil.findChild(self.content, "Nego_Bottom")

	self._imgIcon = goutil.findChild(top, "ImgC_Con")
	self._txtName = goutil.findChildTextComponent(top, "TxtC_Name")
	self._txtLevel = goutil.findChildTextComponent(top, "TxtC_Type/TxtC_level")
	self._txtDesc = goutil.findChildTextComponent(bottom, "TxtC_Desc")
	self._customInput = UICustomInput.Get(self.content)
	self._adjustPosition = self.content:GetComponent("UIAdjustPosition")
	self._contentSizeImmediate = self.content:GetComponent("ContentSizeImmediate")
end

function MartialContestEquipTipView:onEnter()
	MartialContestEquipTipView.super.onEnter(self)

	local params = self:getOpenParam()
	local data = params[1]
	local pos = params[2]
	local sizeDelta = params[3]
	local activityId = data.activityId
	local equipId = data.id
	local level = checknumber(data.lv)
	local curCfg = MartialContestConfig.instance:getEquipCfg(activityId, equipId, level)

	self._txtName.text = curCfg.name
	self._txtDesc.text = curCfg.desc

	uGuiUtil.setSpriteToImage(self._imgIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(curCfg and curCfg.icon))

	self._txtLevel.text = " Lv." .. level

	if self._contentSizeImmediate then
		local size = self._contentSizeImmediate:GetPreferredSize()

		print("size w = " .. size.x .. " h = " .. size.y)
	end

	Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)

	if pos then
		local rect = self.mainGO.transform.rect

		GameUtil.AdjustWithSize(self.content, pos, sizeDelta[1], sizeDelta[2], rect.width, rect.height, false)
		settimer(0.5, function()
			local rect = self.mainGO.transform.rect

			GameUtil.AdjustWithSize(self.content, pos, sizeDelta[1], sizeDelta[2], rect.width, rect.height, false)
		end, nil, false)
	end
end

return MartialContestEquipTipView
