-- chunkname: @modules/logic/rouge/dlc/101/view/RougeLimiterOverView.lua

module("modules.logic.rouge.dlc.101.view.RougeLimiterOverView", package.seeall)

local RougeLimiterOverView = class("RougeLimiterOverView", BaseView)

RougeLimiterOverView.TabType = {
	Buff = 2,
	Debuff = 1
}

function RougeLimiterOverView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._btndebuff = gohelper.findChildButtonWithAudio(self.viewGO, "root/top/#btn_debuff")
	self._btnbuff = gohelper.findChildButtonWithAudio(self.viewGO, "root/top/#btn_buff")
	self._txtdifficulty = gohelper.findChildText(self.viewGO, "root/bottom/difficultybg/#txt_difficulty")
	self._txtdec1 = gohelper.findChildText(self.viewGO, "root/bottom/#txt_dec1")
	self._txtdec2 = gohelper.findChildText(self.viewGO, "root/bottom/#txt_dec2")
	self._txtdec3 = gohelper.findChildText(self.viewGO, "root/bottom/#txt_dec3")
	self._goempty = gohelper.findChild(self.viewGO, "root/#go_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeLimiterOverView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btndebuff:AddClickListener(self._btndebuffOnClick, self)
	self._btnbuff:AddClickListener(self._btnbuffOnClick, self)
end

function RougeLimiterOverView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btndebuff:RemoveClickListener()
	self._btnbuff:RemoveClickListener()
end

function RougeLimiterOverView:_btncloseOnClick()
	self:closeThis()
end

function RougeLimiterOverView:_btndebuffOnClick()
	self:try2SwtichTabView(RougeLimiterOverView.TabType.Debuff)
end

function RougeLimiterOverView:_btnbuffOnClick()
	self:try2SwtichTabView(RougeLimiterOverView.TabType.Buff)
end

function RougeLimiterOverView:try2SwtichTabView(tabId)
	if self._curTabId == tabId then
		return
	end

	self._curTabId = tabId

	self.viewContainer:switchTab(tabId)
	self:refreshUI()
end

function RougeLimiterOverView:refreshUI()
	self:refreshBarUI()
	self:refreshDifficulty()
	self:refreshEmptyUI()
end

function RougeLimiterOverView:refreshBarUI()
	local gounselectdebuff = gohelper.findChild(self._btndebuff.gameObject, "unselect")
	local goselectdebuff = gohelper.findChild(self._btndebuff.gameObject, "selected")
	local gounselectbuff = gohelper.findChild(self._btnbuff.gameObject, "unselect")
	local goselectbuff = gohelper.findChild(self._btnbuff.gameObject, "selected")

	gohelper.setActive(gounselectdebuff, self._curTabId ~= RougeLimiterOverView.TabType.Debuff)
	gohelper.setActive(goselectdebuff, self._curTabId == RougeLimiterOverView.TabType.Debuff)
	gohelper.setActive(gounselectbuff, self._curTabId ~= RougeLimiterOverView.TabType.Buff)
	gohelper.setActive(goselectbuff, self._curTabId == RougeLimiterOverView.TabType.Buff)
end

function RougeLimiterOverView:refreshDifficulty()
	if self.viewParam then
		if not self.viewParam.totalRiskValue then
			local totalRiskValue = 0
			local riskCO = RougeDLCConfig101.instance:getRougeRiskCoByRiskValue(totalRiskValue)

			self._txtdifficulty.text = riskCO and riskCO.title

			self:refreshDesc(riskCO and riskCO.desc)
		end
	end
end

function RougeLimiterOverView:refreshDesc(descStr)
	local useMap = {}

	if not string.nilorempty(descStr) then
		local descList = string.split(descStr, "|")

		for index, desc in ipairs(descList) do
			local txtdesc = self["_txtdec" .. index]

			txtdesc.text = desc
			useMap[txtdesc] = true

			gohelper.setActive(txtdesc.gameObject, true)
		end
	end

	for index = 1, RougeDLCEnum101.MaxRiskDescCount do
		local txtdesc = self["_txtdec" .. index]

		if txtdesc and not useMap[txtdesc] then
			gohelper.setActive(txtdesc.gameObject, false)
		end
	end
end

function RougeLimiterOverView:refreshEmptyUI()
	local isEmpty = false

	if self._curTabId == RougeLimiterOverView.TabType.Debuff then
		if self.viewParam then
			local limiterIds = self.viewParam.limiterIds

			if limiterIds then
				if not #limiterIds then
					local limiterIdCount = 0

					isEmpty = limiterIdCount <= 0
				end
			end
		end
	elseif self._curTabId == RougeLimiterOverView.TabType.Buff then
		if self.viewParam then
			local buffIds = self.viewParam.buffIds

			if buffIds then
				if not #buffIds then
					local buffIdCount = 0

					isEmpty = buffIdCount <= 0
				end
			end
		end
	end

	gohelper.setActive(self._goempty, isEmpty)
end

function RougeLimiterOverView:_editableInitView()
	return
end

function RougeLimiterOverView:onUpdateParam()
	return
end

function RougeLimiterOverView:onOpen()
	self._curTabId = RougeLimiterOverView.TabType.Debuff

	self:refreshUI()
end

function RougeLimiterOverView:onClose()
	return
end

function RougeLimiterOverView:onDestroyView()
	return
end

return RougeLimiterOverView
