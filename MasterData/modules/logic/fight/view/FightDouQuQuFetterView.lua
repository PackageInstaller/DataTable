-- chunkname: @modules/logic/fight/view/FightDouQuQuFetterView.lua

module("modules.logic.fight.view.FightDouQuQuFetterView", package.seeall)

local FightDouQuQuFetterView = class("FightDouQuQuFetterView", FightBaseView)

function FightDouQuQuFetterView:onInitView()
	self.content = gohelper.findChild(self.viewGO, "root/fetters/Viewport/Content")
	self.itemObj = gohelper.findChild(self.viewGO, "root/fetters/Viewport/Content/FetterItem")
end

function FightDouQuQuFetterView:addEvents()
	return
end

function FightDouQuQuFetterView:onConstructor(entityMO)
	self.entityMO = entityMO
end

function FightDouQuQuFetterView:refreshEntityMO(entityMO)
	self.entityMO = entityMO

	if self.viewGO then
		self:refreshFetter()
	end
end

function FightDouQuQuFetterView:onOpen()
	local tab = {}

	for k, v in pairs(lua_activity191_relation.configDict) do
		local tag = v.tag

		tab[tag] = tab[tag] or {}

		table.insert(tab[tag], v)
	end

	for k, v in pairs(tab) do
		table.sort(v, function(a, b)
			return a.activeNum < b.activeNum
		end)
	end

	self.configDic = tab
	self.customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191]

	self:refreshFetter()
end

function FightDouQuQuFetterView:refreshFetter()
	if self.entityMO.side == FightEnum.EntitySide.MySide then
		if not self.customData.teamATag2NumMap then
			local data = self.customData.teamBTag2NumMap

			if data and tabletool.len(data) > 0 then
				gohelper.setActive(self.viewGO, true)

				local list = {}

				for k, v in pairs(data) do
					table.insert(list, {
						key = k,
						value = v
					})
				end

				for _, v in ipairs(list) do
					for index = #self.configDic[v.key], 1, -1 do
						local config = self.configDic[v.key][index]

						if v.value >= config.activeNum then
							v.config = config

							if config.activeNum > 0 then
								v.active = true
							end

							break
						end
					end
				end

				table.sort(list, FightDouQuQuFetterView.sortItemListData)
				self:com_createObjList(self.onItemShow, list, self.content, self.itemObj)
			else
				gohelper.setActive(self.viewGO, false)
			end
		end
	end
end

function FightDouQuQuFetterView.sortItemListData(a, b)
	local aActive = a.active
	local bActive = b.active

	if aActive and not bActive then
		return true
	elseif not aActive and bActive then
		return false
	else
		local aConfig = a.config
		local bConfig = b.config

		if aConfig.level == bConfig.level then
			if a.value == b.value then
				return aConfig.id < bConfig.id
			else
				return a.value > b.value
			end
		else
			return aConfig.level > bConfig.level
		end

		return false
	end
end

function FightDouQuQuFetterView:onItemShow(obj, data, index)
	local bg = gohelper.findChildImage(obj, "image_Bg")
	local img = gohelper.findChildImage(obj, "image_Fetter")
	local text = gohelper.findChildText(obj, "txt_FetterCnt")
	local tag = data.key
	local value = data.value
	local maxCo = Activity191Config.instance:getRelationMaxCo(tag)
	local level = 0
	local curConfig = maxCo

	for i, v in ipairs(self.configDic[tag]) do
		if value >= v.activeNum then
			level = v.level
			curConfig = v
		end
	end

	local colorLeft = level == 0 and "#ED7F7F" or "#F0E2CA"
	local colorRight = level == 0 and "#838383" or "#F0E2CA"

	text.text = string.format("<%s>%s</color><%s>/%s</color>", colorLeft, value, colorRight, maxCo.activeNum)

	UISpriteSetMgr.instance:setAct174Sprite(bg, "act174_shop_tag_" .. curConfig.tagBg)
	ZProj.UGUIHelper.SetGrayscale(bg.gameObject, level == 0)
	Activity191Helper.setFetterIcon(img, curConfig.icon)

	local click = gohelper.getClickWithDefaultAudio(obj)
	local param = {
		isFight = true,
		count = value,
		tag = curConfig.tag
	}

	self:com_registClick(click, self.onClickItem, param)
end

function FightDouQuQuFetterView:onClickItem(param)
	Activity191Controller.instance:openFetterTipView(param)
end

return FightDouQuQuFetterView
