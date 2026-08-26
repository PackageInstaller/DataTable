-- chunkname: @modules/logic/explore/view/ExploreGuideView.lua

module("modules.logic.explore.view.ExploreGuideView", package.seeall)

local ExploreGuideView = class("ExploreGuideView", BaseView)

function ExploreGuideView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_bg")
	self._simagedecorate1 = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_decorate1")
	self._simagedecorate3 = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_decorate3")
	self._btnlook = gohelper.findChildButtonWithAudio(self.viewGO, "commen/#btn_look")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ExploreGuideView:addEvents()
	self._btnlook:AddClickListener(self._btnlookOnClick, self)
end

function ExploreGuideView:removeEvents()
	self._btnlook:RemoveClickListener()
end

function ExploreGuideView:_btnlookOnClick()
	self:closeThis()
end

function ExploreGuideView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getWeekWalkBg("yd_yindaodi_1.png"))
	self._simagedecorate1:LoadImage(ResUrl.getCommonIcon("yd_biaoti_di"))
	self._simagedecorate3:LoadImage(ResUrl.getCommonIcon("yd_blxian"))
end

function ExploreGuideView:onUpdateParam()
	self:_setAnim()
end

function ExploreGuideView:_setAnim(isFirst)
	local var_7_0 = self.viewParam

	if self.viewParam then
		var_7_0 = self.viewParam.viewParam

		if self.viewParam.viewParam then
			local viewParam = self.viewParam.viewParam[1]

			viewParam = viewParam or 1

			if not isFirst and viewParam == 4 then
				return
			end

			if AudioEnum.Explore["ExploreGuideUnlock" .. viewParam] then
				AudioMgr.instance:trigger(AudioEnum.Explore["ExploreGuideUnlock" .. viewParam])
			end

			local animName = tostring(viewParam)

			self._anim:Play(animName, 0, 0)
		end
	end
end

function ExploreGuideView:onOpen()
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self:_setAnim(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_artificial_ui_openfunction)
end

function ExploreGuideView:onClose()
	return
end

function ExploreGuideView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagedecorate1:UnLoadImage()
	self._simagedecorate3:UnLoadImage()
end

return ExploreGuideView
