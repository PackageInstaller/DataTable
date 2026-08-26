-- chunkname: @modules/ugui/icon/IconMgr.lua

module("modules.ugui.icon.IconMgr", package.seeall)

local IconMgr = class("IconMgr")

function IconMgr:preload(callback, callbackObj)
	self._callback = callback
	self._callbackObj = callbackObj
	self._resDict = {}
	self._loader = MultiAbLoader.New()

	self._loader:setPathList(IconMgrConfig.getPreloadList())
	self._loader:setOneFinishCallback(self._onOnePreloadCallback, self)
	self._loader:startLoad(self._onPreloadCallback, self)

	self._liveIconReferenceTimeDic = {}
	self._liveIconCountDic = {}
end

function IconMgr:getCommonPropItemIcon(parentGO)
	local itemIconGO = self:_getIconInstance(IconMgrConfig.UrlPropItemIcon, parentGO)

	if itemIconGO then
		return MonoHelper.addNoUpdateLuaComOnceToGo(itemIconGO, CommonPropItemIcon)
	end
end

function IconMgr:getCommonPropListItemIcon(parentGO)
	local itemIconGO = self:_getIconInstance(IconMgrConfig.UrlPropItemIcon, parentGO)

	if itemIconGO then
		return MonoHelper.addNoUpdateLuaComOnceToGo(itemIconGO, CommonPropListItem)
	end
end

function IconMgr:getCommonPropItemIconList(class, callback, data, parent_obj)
	self:CreateCellList(class, callback, data, parent_obj, IconMgrConfig.UrlPropItemIcon, CommonPropItemIcon)
end

function IconMgr:getCommonItemIcon(parentGO)
	local itemIconGO = self:_getIconInstance(IconMgrConfig.UrlItemIcon, parentGO)

	if itemIconGO then
		return MonoHelper.addNoUpdateLuaComOnceToGo(itemIconGO, CommonItemIcon)
	end
end

function IconMgr:getCommonEquipIcon(parentGO, scale)
	local equipIconGO = self:_getIconInstance(IconMgrConfig.UrlEquipIcon, parentGO)

	if equipIconGO then
		if scale then
			transformhelper.setLocalScale(equipIconGO.transform, scale, scale, scale)
		end

		return MonoHelper.addNoUpdateLuaComOnceToGo(equipIconGO, CommonEquipIcon)
	end
end

function IconMgr:getCommonHeroIcon(parentGO)
	local heroIconGO = self:_getIconInstance(IconMgrConfig.UrlHeroIcon, parentGO)

	if heroIconGO then
		return MonoHelper.addNoUpdateLuaComOnceToGo(heroIconGO, CommonHeroIcon)
	end
end

function IconMgr:getCommonHeroIconNew(parentGO)
	local heroIconGO = self:_getIconInstance(IconMgrConfig.UrlHeroIconNew, parentGO)

	if heroIconGO then
		return MonoHelper.addNoUpdateLuaComOnceToGo(heroIconGO, CommonHeroIconNew)
	end
end

function IconMgr:getCommonHeroItem(parentGO)
	local heroItemGO = self:_getIconInstance(IconMgrConfig.UrlHeroItemNew, parentGO)

	if heroItemGO then
		return MonoHelper.addNoUpdateLuaComOnceToGo(heroItemGO, CommonHeroItem)
	end
end

function IconMgr:getCommonPlayerIcon(parentGO)
	local playerIconGO = self:_getIconInstance(IconMgrConfig.UrlPlayerIcon, parentGO)

	if playerIconGO then
		return MonoHelper.addNoUpdateLuaComOnceToGo(playerIconGO, CommonPlayerIcon)
	end
end

function IconMgr:getRoomGoodsItem(parentGO, viewContainer)
	local RoomGoodsItemGO = viewContainer and viewContainer:getResInst(IconMgrConfig.UrlRoomGoodsItemIcon, parentGO)

	if RoomGoodsItemGO then
		return MonoHelper.addNoUpdateLuaComOnceToGo(RoomGoodsItemGO, RoomGoodsItem)
	end
end

function IconMgr:getCommonTextMarkTop(parentGo)
	return (self:_getIconInstance(IconMgrConfig.UrlCommonTextMarkTop, parentGo))
end

function IconMgr:getCommonHeadIcon(parentGO)
	local headIconGO = self:_getIconInstance(IconMgrConfig.UrlHeadIcon, parentGO)

	if headIconGO then
		return MonoHelper.addNoUpdateLuaComOnceToGo(headIconGO, CommonHeadIcon)
	end
end

function IconMgr:getCommonCritterIcon(parentGO)
	local critterIconGO = self:_getIconInstance(IconMgrConfig.UrlCritterIcon, parentGO)

	if critterIconGO then
		return MonoHelper.addNoUpdateLuaComOnceToGo(critterIconGO, CommonCritterIcon)
	end
end

function IconMgr:getCommonIconTag(parentGO)
	local iconTagGO = self:_getIconInstance(IconMgrConfig.UrlIconTag, parentGO)

	if iconTagGO then
		return MonoHelper.addNoUpdateLuaComOnceToGo(iconTagGO, CommonIconTag)
	end
end

function IconMgr:_getIconInstance(prefabUrl, parentGO)
	local prefabAssetItem = self._resDict[prefabUrl]

	if prefabAssetItem then
		local prefab = prefabAssetItem:GetResource(prefabUrl)

		if prefab then
			return gohelper.clone(prefab, parentGO)
		else
			logError(prefabUrl .. " prefab not in ab")
		end
	end

	logError(prefabUrl .. " iconPrefab need preload")
end

function IconMgr:_onOnePreloadCallback(loader, assetItem)
	self._resDict[assetItem.ResPath] = assetItem
end

function IconMgr:_onPreloadCallback()
	if self._callback then
		self._callback(self._callbackObj)
	end

	self._callback = nil
	self._callbackObj = nil
end

function IconMgr:CreateCellList(class, callback, data, parent_obj, prefabUrl, component)
	local model_obj = self:getModelPrefab(prefabUrl)

	gohelper.CreateObjList(class, callback, data, parent_obj, model_obj, component)
end

function IconMgr:getModelPrefab(prefabUrl)
	return self._resDict[prefabUrl]:GetResource(prefabUrl)
end

function IconMgr:getCommonLiveHeadIcon(simageHeadIcon)
	local dynamicHeadIcon = MonoHelper.addNoUpdateLuaComOnceToGo(simageHeadIcon.gameObject, CommonLiveHeadIcon)

	dynamicHeadIcon:init(simageHeadIcon)

	return dynamicHeadIcon
end

function IconMgr.setHeadIcon(itemId, headIcon, liveHeadIcon, setNativeSize, closeImage, isParallel, alpha, callBack, callBackObj)
	itemId = tonumber(itemId)
	setNativeSize = not not setNativeSize
	closeImage = not not closeImage
	isParallel = not not isParallel

	local config = lua_item.configDict[itemId]

	if config == nil then
		return
	end

	if alpha then
		local imageComp = headIcon.gameObject:GetComponent(gohelper.Type_Image)

		ZProj.UGUIHelper.SetColorAlpha(imageComp, alpha)
	end

	local portraitId = tonumber(config.icon)
	local isDynamic = config.isDynamic == IconMgrConfig.HeadIconType.Dynamic

	if isDynamic then
		if not liveHeadIcon then
			if isParallel then
				if not headIcon.transform.parent.gameObject then
					local parent = headIcon.transform.gameObject

					liveHeadIcon = MonoHelper.addNoUpdateLuaComOnceToGo(headIcon.gameObject, CommonLiveHeadIcon)

					liveHeadIcon:init(parent)
				end
			end
		end

		liveHeadIcon:setLiveHead(portraitId, headIcon.gameObject, setNativeSize, isParallel, alpha)
	else
		local icon = ItemConfig.instance:getItemIconById(portraitId)
		local finalCallBack = setNativeSize and function()
			if setNativeSize then
				headIcon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
			end

			if callBack then
				callBack(callBackObj)
			end
		end or callBack

		if setNativeSize then
			-- block empty
		end

		local finalCallBackObj = callBackObj

		headIcon:LoadImage(ResUrl.getPlayerHeadIcon(icon), finalCallBack, finalCallBackObj)
	end

	if liveHeadIcon then
		liveHeadIcon:setVisible(isDynamic)
	end

	if closeImage then
		gohelper.setActive(headIcon.gameObject, not isDynamic)
	end

	return liveHeadIcon
end

function IconMgr:addLiveIconAnimationReferenceTime(headId)
	if self._liveIconReferenceTimeDic == nil or self._liveIconCountDic == nil then
		self._liveIconReferenceTimeDic = {}
		self._liveIconCountDic = {}
	end

	logNormal("Add LiveIcon")

	if not self._liveIconReferenceTimeDic[headId] then
		self._liveIconCountDic[headId] = 1
		self._liveIconReferenceTimeDic[headId] = UnityEngine.Time.timeSinceLevelLoad
	else
		local haveCount = self._liveIconCountDic[headId]

		self._liveIconCountDic[headId] = haveCount + 1
	end
end

function IconMgr:removeHeadLiveIcon(headId)
	if not self._liveIconReferenceTimeDic[headId] then
		logNormal("Have no headLiveIcon Reference")

		return
	end

	logNormal("Remove LiveIcon")

	local count = self._liveIconCountDic[headId]
	local finalCount = math.max(0, count - 1)

	if finalCount <= 0 then
		self._liveIconReferenceTimeDic[headId] = nil
		self._liveIconCountDic[headId] = nil
	else
		self._liveIconCountDic[headId] = finalCount
	end
end

function IconMgr:getLiveIconReferenceTime(headId)
	if not self._liveIconReferenceTimeDic or not self._liveIconReferenceTimeDic[headId] then
		logError("Have no ReferenceTime id: " .. tostring(headId))

		return 0
	end

	return self._liveIconReferenceTimeDic[headId]
end

IconMgr.instance = IconMgr.New()

return IconMgr
