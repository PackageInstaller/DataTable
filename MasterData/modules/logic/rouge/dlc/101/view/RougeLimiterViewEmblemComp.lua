-- chunkname: @modules/logic/rouge/dlc/101/view/RougeLimiterViewEmblemComp.lua

module("modules.logic.rouge.dlc.101.view.RougeLimiterViewEmblemComp", package.seeall)

local RougeLimiterViewEmblemComp = class("RougeLimiterViewEmblemComp", BaseView)

function RougeLimiterViewEmblemComp:ctor(rootPath)
	RougeLimiterViewEmblemComp.super.ctor(self)

	self.rootPath = rootPath
end

function RougeLimiterViewEmblemComp:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, self.rootPath)
	self._txtpoint = gohelper.findChildText(self._goroot, "point/#txt_point")
	self._btnclick = gohelper.findChildButtonWithAudio(self._goroot, "point/#btn_click")
	self._gotips = gohelper.findChild(self._goroot, "tips")
	self._txttips = gohelper.findChildText(self._goroot, "tips/#txt_tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeLimiterViewEmblemComp:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function RougeLimiterViewEmblemComp:removeEvents()
	self._btnclick:RemoveClickListener()
end

function RougeLimiterViewEmblemComp:_btnclickOnClick()
	self._isTipVisible = not self._isTipVisible

	gohelper.setActive(self._gotips, self._isTipVisible)
end

function RougeLimiterViewEmblemComp:_editableInitView()
	self.addEventCb(self, RougeDLCController101.instance, RougeDLCEvent101.UpdateEmblem, self._onUpdateEmblem, self)
end

function RougeLimiterViewEmblemComp:onUpdateParam()
	return
end

function RougeLimiterViewEmblemComp:onOpen()
	self._emblemCount = RougeDLCModel101.instance:getTotalEmblemCount()

	self:initEmblemCount()
	self:refreshEmblemTips()
end

function RougeLimiterViewEmblemComp:initEmblemCount()
	self._txtpoint.text = self._emblemCount
end

function RougeLimiterViewEmblemComp:refreshEmblemTips()
	local maxEmbleCountCo = lua_rouge_dlc_const.configDict[RougeDLCEnum101.Const.MaxEmblemCount]

	if maxEmbleCountCo then
		if not maxEmbleCountCo.value then
			local maxEmblemCount = 0
			local params = {
				self._emblemCount,
				maxEmblemCount
			}

			self._txttips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_dlc_101_emblemTips"), params)
		end
	end
end

function RougeLimiterViewEmblemComp:_onUpdateEmblem()
	self._emblemCount = RougeDLCModel101.instance:getTotalEmblemCount()

	self:initEmblemCount()
	self:refreshEmblemTips()
end

function RougeLimiterViewEmblemComp:onClose()
	return
end

function RougeLimiterViewEmblemComp:onDestroyView()
	return
end

return RougeLimiterViewEmblemComp
