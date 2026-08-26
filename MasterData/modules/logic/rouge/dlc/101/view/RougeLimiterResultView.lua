-- chunkname: @modules/logic/rouge/dlc/101/view/RougeLimiterResultView.lua

module("modules.logic.rouge.dlc.101.view.RougeLimiterResultView", package.seeall)

local RougeLimiterResultView = class("RougeLimiterResultView", BaseView)

function RougeLimiterResultView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg")
	self._imagebadge = gohelper.findChildImage(self.viewGO, "Single/Top/#image_badge")
	self._goadd1 = gohelper.findChild(self.viewGO, "Single/Top/#go_add1")
	self._txtadd1 = gohelper.findChildText(self.viewGO, "Single/Top/#go_add1/#txt_add1")
	self._gocurrent1 = gohelper.findChild(self.viewGO, "Single/Top/#go_current1")
	self._txtcurrent1 = gohelper.findChildText(self.viewGO, "Single/Top/#go_current1/#txt_current1")
	self._goadd2 = gohelper.findChild(self.viewGO, "Two/Top/#go_add2")
	self._txtadd2 = gohelper.findChildText(self.viewGO, "Two/Top/#go_add2/#txt_add2")
	self._gocurrent2 = gohelper.findChild(self.viewGO, "Two/Top/#go_current2")
	self._txtcurrent2 = gohelper.findChildText(self.viewGO, "Two/Top/#go_current2/#txt_current2")
	self._gobuffitem = gohelper.findChild(self.viewGO, "Two/Bottom/#go_buffitem")
	self._imagebufficon = gohelper.findChildImage(self.viewGO, "Two/Bottom/#go_buffitem/#image_bufficon")
	self._txtbuffname = gohelper.findChildText(self.viewGO, "Two/Bottom/#go_buffitem/#txt_buffname")
	self._txtbuffdec = gohelper.findChildText(self.viewGO, "Two/Bottom/#go_buffitem/#txt_buffdec")
	self._btnclosebtn = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closebtn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeLimiterResultView:addEvents()
	self._btnclosebtn:AddClickListener(self._btnclosebtnOnClick, self)
end

function RougeLimiterResultView:removeEvents()
	self._btnclosebtn:RemoveClickListener()
end

function RougeLimiterResultView:_btnclosebtnOnClick()
	self:closeThis()
end

function RougeLimiterResultView:_editableInitView()
	self._gosingle = gohelper.findChild(self.viewGO, "Single")
	self._gotwo = gohelper.findChild(self.viewGO, "Two")
end

function RougeLimiterResultView:onUpdateParam()
	return
end

function RougeLimiterResultView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.OpenLimiterResultView)
	self:refreshUI()
end

function RougeLimiterResultView:refreshUI()
	local rougeResult = RougeModel.instance:getRougeResult()
	local limiterResultMo = rougeResult and rougeResult:getLimiterResultMo()
	local buffIds = limiterResultMo and limiterResultMo:getLimiterUseBuffIds()
	local hasNeedCDBuff = buffIds and #buffIds > 0
	local addEmblemCount = limiterResultMo and limiterResultMo:getLimiterAddEmblem()
	local preEmblemCount = limiterResultMo and limiterResultMo:getPreEmbleCount()

	gohelper.setActive(self._gosingle, not hasNeedCDBuff)
	gohelper.setActive(self._gotwo, hasNeedCDBuff)
	self:refreshEmblem(hasNeedCDBuff, preEmblemCount, addEmblemCount)
	self:refreshCDBuffs(buffIds)
end

function RougeLimiterResultView:refreshEmblem(hasNeedCDBuff, preEmblemCount, addEmblemCount)
	local maxEmbleCountCo = lua_rouge_dlc_const.configDict[RougeDLCEnum101.Const.MaxEmblemCount]
	local maxEmblemCount = maxEmbleCountCo and tonumber(maxEmbleCountCo.value) or 0
	local canGetEmbleNum = GameUtil.clamp(maxEmblemCount - preEmblemCount, 0, maxEmblemCount)
	local addEmblemResult = addEmblemCount

	if canGetEmbleNum < addEmblemCount then
		addEmblemResult = canGetEmbleNum
	end

	local totalEmblemCount = preEmblemCount + addEmblemResult
	local addEmblemStr = string.format("+ %s", addEmblemResult or 0)
	local totalEmblemStr = formatLuaLang("rouge_dlc_101_emblemCount", totalEmblemCount)
	local isMax = maxEmblemCount <= totalEmblemCount

	if isMax then
		totalEmblemStr = string.format("%s (MAX)", totalEmblemStr)
	end

	if hasNeedCDBuff then
		self._txtadd2.text = addEmblemStr
		self._txtcurrent2.text = totalEmblemStr
	else
		self._txtadd1.text = addEmblemStr
		self._txtcurrent1.text = totalEmblemStr
	end
end

function RougeLimiterResultView:refreshCDBuffs(buffIds)
	local useMap = {}

	for index, buffId in ipairs(buffIds or {}) do
		local buffItem = self:_getOrCreateBuffItem(index)
		local buffCo = RougeDLCConfig101.instance:getLimiterBuffCo(buffId)

		gohelper.setActive(buffItem.viewGO, true)

		buffItem.txtTitle.text = buffCo and buffCo.title
		buffItem.txtDec.text = buffCo and buffCo.desc

		UISpriteSetMgr.instance:setRouge4Sprite(buffItem.imageIcon, buffCo.icon)

		useMap[buffItem] = true
	end

	if self._buffItemTab then
		for _, buffItem in pairs(self._buffItemTab) do
			if not useMap[buffItem] then
				gohelper.setActive(buffItem.viewGO, false)
			end
		end
	end
end

function RougeLimiterResultView:_getOrCreateBuffItem(index)
	self._buffItemTab = self.buffItemTab or self:getUserDataTb_()

	local buffItem = self._buffItemTab[index]

	if not buffItem then
		buffItem = self:getUserDataTb_()
		buffItem.viewGO = gohelper.cloneInPlace(self._gobuffitem, "buffitem_" .. index)
		buffItem.txtTitle = gohelper.findChildText(buffItem.viewGO, "#txt_buffname")
		buffItem.txtDec = gohelper.findChildText(buffItem.viewGO, "#txt_buffdec")
		buffItem.imageIcon = gohelper.findChildImage(buffItem.viewGO, "#image_bufficon")
		self._buffItemTab[index] = buffItem
	end

	return buffItem
end

function RougeLimiterResultView:onClose()
	return
end

function RougeLimiterResultView:onDestroyView()
	return
end

return RougeLimiterResultView
