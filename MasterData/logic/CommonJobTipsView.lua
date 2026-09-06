-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/CommonJobTipsView.lua

module("logic.extensions.common.instruction.view.CommonJobTipsView", package.seeall)

local CommonJobTipsView = class("CommonJobTipsView", ViewComponent)

function CommonJobTipsView:ctor()
	CommonJobTipsView.super.ctor(self)
end

function CommonJobTipsView:destroyUI()
	CommonJobTipsView.super.destroyUI(self)
end

function CommonJobTipsView:onExitFinished()
	CommonJobTipsView.super.onExitFinished(self)
end

function CommonJobTipsView:onEnterFinished()
	CommonJobTipsView.super.onEnterFinished(self)
end

function CommonJobTipsView:unbindEvents()
	CommonJobTipsView.super.unbindEvents(self)
end

function CommonJobTipsView:bindEvents()
	CommonJobTipsView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function CommonJobTipsView:onExit()
	CommonJobTipsView.super.onExit(self)
end

function CommonJobTipsView:buildUI()
	CommonJobTipsView.super.buildUI(self)

	self._Nego_Content = goutil.findChild(self.mainGO, "Nego_Content")
	self._adjustPosition = self._Nego_Content:GetComponent("UIAdjustPosition")
	self._customInput = UICustomInput.Get(self._Nego_Content)
	self.itemList = {}
	self._txtDescList = {}

	for k, v in pairs(GameEnum.JobZh) do
		local go = goutil.findChild(self._Nego_Content, "item" .. v)

		if go then
			self.itemList[v] = {}
			self.itemList[v].go = go
			self.itemList[v].txtDesc = goutil.findChildTextComponent(go, "txtDesc")
			self.itemList[v].txtName = goutil.findChildTextComponent(go, "left/txtName")
		end
	end
end

function CommonJobTipsView:onEnter()
	CommonJobTipsView.super.onEnter(self)

	local data = self._viewPresentor._openParam[1]
	local pos = self._viewPresentor._openParam[2]

	if not self._viewPresentor._openParam[3] then
		Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
		Framework.TransformUtil.SetLocalPos(self._Nego_Content.transform, 0, 0, 0)

		local rect = self.mainGO.transform.rect

		GameUtil.AdjustWithSize(self._Nego_Content, pos, self._viewPresentor._openParam[3][1], self._viewPresentor._openParam[3][2], rect.width, rect.height, false)

		if pos then
			-- block empty
		end

		local job = data.id

		for k, v in pairs(self.itemList) do
			if k == job then
				GameUtil.SetActive(v.go, true)

				local cfg = CharacterConfig.instance:getJobCo(job)

				v.txtDesc.text = cfg.desc
				v.txtName.text = cfg.name
			else
				GameUtil.SetActive(v.go, false)
			end
		end
	end
end

function CommonJobTipsView:_onCustomInputCallback(hover)
	CommonTipsMgr.instance:doWillClose(self, hover)
end

return CommonJobTipsView
