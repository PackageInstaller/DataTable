-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingciyuanchallenge/view/KingciyuanchallengebuffpopupView.lua

module("logic.extensions.kingciyuanchallenge.view.KingciyuanchallengebuffpopupView", package.seeall)

local KingciyuanchallengebuffpopupView = class("KingciyuanchallengebuffpopupView", ViewComponent)

function KingciyuanchallengebuffpopupView:ctor()
	KingciyuanchallengebuffpopupView.super.ctor(self)
end

function KingciyuanchallengebuffpopupView:unbindEvents()
	KingciyuanchallengebuffpopupView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function KingciyuanchallengebuffpopupView:bindEvents()
	KingciyuanchallengebuffpopupView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function KingciyuanchallengebuffpopupView:buildUI()
	KingciyuanchallengebuffpopupView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._emptyGo = self:getGo("buff/empty")

	GameUtil.SetActive(self._emptyGo, false)

	self._buffIcon = self:getGo("buffInfo/buffIcon")
	self._txtTitle = self:getTxt("buffInfo/txtTitle")
	self._txtContent = self:getTxt("buffInfo/txtscrollContent/Viewport/txtContent")

	local scrollerGo = self:getGo("buff/tableview")
	local cellGo = self:getGo("buff/buffCell")

	GameUtil.SetActive(cellGo, false)

	self._scrollList = ScrollerList.create(scrollerGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function KingciyuanchallengebuffpopupView:onExit()
	KingciyuanchallengebuffpopupView.super.onExit(self)
	self._scrollList:dispose()
	uGuiUtil.clearImage(self._buffIcon)
end

function KingciyuanchallengebuffpopupView:onEnter()
	KingciyuanchallengebuffpopupView.super.onEnter(self)

	local buffMap = self:_calculateBuffMap()
	local buffArray = {}
	local allTagConfigs = KingCiYuanChallengeConfig.instance:getAllTagConfigs()

	for i, v in ipairs(allTagConfigs) do
		table.insert(buffArray, v)
	end

	table.sort(buffArray, function(a, b)
		local bSuitA = a[1].type == KingCiYuanChallengeConfig.BuffType_Suit
		local bSuitB = b[1].type == KingCiYuanChallengeConfig.BuffType_Suit

		if bSuitA == bSuitB then
			local levelA = checknumber(buffMap[a[1].tagId])
			local levelB = checknumber(buffMap[b[1].tagId])

			return levelB < levelA
		else
			return bSuitA
		end
	end)

	self._configs = buffArray
	self._buffMap = buffMap

	self:_onClickCell(self._configs[1])
	KingCiYuanChallengeModel.instance:updateExtFightBuffRed(true)
end

function KingciyuanchallengebuffpopupView:_calculateBuffMap()
	local buffMap = {}
	local buffs = KingCiYuanChallengeModel.instance:getJxBuffs()

	for _, data in ipairs(buffs) do
		buffMap[data.buffId] = data.count
	end

	local suitConfigs = KingCiYuanChallengeConfig.instance:getSuitConfigs()

	for _, config in ipairs(suitConfigs) do
		local curSuitConfigs = KingCiYuanChallengeConfig.instance:getTagConfigs(config.tagId)

		for i = #curSuitConfigs, 0, -1 do
			local curSuitConfig = curSuitConfigs[i]

			if curSuitConfig then
				local unlock = curSuitConfig.unlock

				if unlock ~= nil and #unlock > 0 then
					local isActive = true

					for _, strUnlockGroup in ipairs(unlock) do
						local arr = string.splitToNumber(strUnlockGroup, "#")
						local needBuffId = arr[1]
						local needCount = arr[2]

						if needCount > checknumber(buffMap[needBuffId]) then
							isActive = false

							break
						end
					end

					if isActive then
						buffMap[curSuitConfig.tagId] = curSuitConfig.level

						break
					end
				end
			end
		end
	end

	return buffMap
end

function KingciyuanchallengebuffpopupView:_getBuffDetail(buffId)
	local curLevel = checknumber(self._buffMap[buffId])
	local configs = KingCiYuanChallengeConfig.instance:getTagConfigs(buffId)
	local config = configs[math.max(curLevel, 1)]

	return curLevel, curLevel > 0, configs, config
end

function KingciyuanchallengebuffpopupView:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local select = goutil.findChild(cell, "select")
	local buffIcon = goutil.findChild(cell, "buffIcon")
	local redPointGo = goutil.findChild(cell, "redpoint")
	local buffId = data[1].tagId
	local curLevel, bActive, configs, config = self:_getBuffDetail(buffId)

	txtDesc.text = bActive and langPara("%s(等级%s)", config.targetName, config.level) or langPara("%s(未激活)", config.targetName)

	GameUtil.SetActive(select, self._data == data)
	GameUtil.SetActive(redPointGo, KingCiYuanChallengeModel.instance:isBuffRed(buffId))
	uGuiUtil.clearImage(buffIcon)
	uGuiUtil.setSpriteToImage(buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(config.iconPath))
	GameUtil.addClickHandler(cell.gameObject, function()
		self:_onClickCell(data)
	end)
end

function KingciyuanchallengebuffpopupView:_clearCell(cell)
	local buffIcon = goutil.findChild(cell, "buffIcon")

	uGuiUtil.clearImage(buffIcon)
	GameUtil.rmClickHandler(cell.gameObject)
end

function KingciyuanchallengebuffpopupView:_onClickCell(data)
	self._data = data

	KingCiYuanChallengeModel.instance:setBuffClick(self._data[1].tagId)
	self._scrollList:reloadData(self._configs)
	self._scrollList:refresh()
	self:_updateDetail()
end

function KingciyuanchallengebuffpopupView:_updateDetail()
	local curLevel, bActive, configs, config = self:_getBuffDetail(self._data[1].tagId)

	uGuiUtil.clearImage(self._buffIcon)
	uGuiUtil.setSpriteToImage(self._buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(config.iconPath))

	self._txtTitle.text = bActive and langPara("%s(等级%s)", config.targetName, config.level) or langPara("%s(未激活)", config.targetName)

	local strContent = ""

	for i, v in ipairs(configs) do
		local strSentences = ""

		strSentences = curLevel >= v.level and string.format("<color=#00af00>等级%s %s</color>", v.level, v.desc or "") or string.format("等级%s %s", v.level, v.desc or "")
		strContent = i == 1 and strSentences or string.format("%s\n%s", strContent, strSentences)
	end

	self._txtContent.text = strContent
end

return KingciyuanchallengebuffpopupView
