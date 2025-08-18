-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RoleInfo\\HeadHelper.lua

local ResRoleHead = require("ClientData/ResRoleHead")
local ResRoleHeadFrame = require("ClientData/ResRoleHeadFrame")
local ResCommonModel = require("ClientData/ResCommonModel")
local UserData = require("Helper/UserData")
local ResHero = require("ClientData/ResHero")
local ResItem = require("ClientData/ResItem")
local ResRoleHeadPendant = require("ClientData/ResRoleHeadPendant")
local ResRoleChatBubble = require("ClientData/ResRoleChatBubble")
local TEST_URL = "http://192.168.1.168:8800/files/head/0704/0739/b01b8f547e3f3a4b313cadcdca25f90e.jpg"
local HEAD_STATUS_HINT = {
	[Const.CUSTOM_HEAD_STATUS.REVIEWING] = Lang.get(30745),
	[Const.CUSTOM_HEAD_STATUS.FORBID] = Lang.get(30746),
	[Const.CUSTOM_HEAD_STATUS.UP_LOAD_FAILD] = Lang.get(30747),
	[Const.CUSTOM_HEAD_STATUS.UP_LOADING] = Lang.get(30748)
}
local SAVE_PREFIX = "head_"
local checkHeadTime = 0
local HeadHelper = {}
local self = HeadHelper

self.TEST_URL = TEST_URL
self.getTimeMap = {}

function HeadHelper.init(...)
	self.saveData = nil
end

function HeadHelper.isCustomHead(headId)
	local customId, normalId, isCustom = self.decodeHeadInfo(headId)

	return isCustom
end

function HeadHelper.decodeHeadInfo(headId)
	if headId < Const.PERSONAL_HEAD_ID then
		return Const.PERSONAL_HEAD_ID, headId, false
	elseif headId == Const.PERSONAL_HEAD_ID then
		return Const.PERSONAL_HEAD_ID, headId, true
	elseif headId < 9999999 then
		local flag = headId % 10
		local normalId = math.floor(headId / 10) % 1000
		local customId = math.floor(headId / 10000)

		return customId, normalId, flag == 1
	else
		local normalId = bit.band(headId, 4095)
		local flag = bit.band(bit.rshift(headId, 12), 15)
		local customId = bit.rshift(headId, 16)

		return customId, normalId, flag == 1
	end
end

function HeadHelper.encodeHeadInfo(customId, normalId, isCustom)
	local flag = isCustom == true and 1 or 0
	local headId = bit.lshift(customId, 4)

	headId = bit.bor(headId, flag)
	headId = bit.lshift(headId, 12)
	headId = bit.bor(headId, normalId)

	return headId
end

function HeadHelper.getMyCustomId(...)
	local customId, normalId, isCustom = self.decodeHeadInfo(CurAvatar.head)

	return customId
end

function HeadHelper.isPostedSuccess(...)
	return self.getMyCustomId() > Const.PERSONAL_HEAD_ID
end

function HeadHelper.setHeadIconWithUnityType(uiController, unityImage, headId, uid)
	local image = {}

	function image:setImage(filePath, spriteName)
		uiController:SetImageSprite(unityImage, filePath, spriteName, false)
	end

	function image:setImageWithTexture(texture)
		local sprite = UnityEngine.Sprite.Create(texture, UnityEngine.Rect(0, 0, texture.width, texture.height), Vector2.zero)

		unityImage.sprite = sprite
	end

	function image.isAlive(...)
		return not tolua.isnull(unityImage)
	end

	function image.setVisible(...)
		return
	end

	self.setHeadIcon(image, headId, uid, false)
end

function HeadHelper.setHeadIcon(image, headId, uid, needUidCheck)
	local customId, normalId, isCustom = self.decodeHeadInfo(headId)

	if image == nil then
		return
	end

	if normalId == 0 then
		normalId = Const.DEFAULT_HEAD
	end

	image.uid = uid

	if isCustom == false then
		local head_path, head_name = self.getHeadID(normalId)

		image:setImage(head_path, head_name)
	else
		self.setDefaultIcon(image)
		self.setCustomHead(image, customId, uid, needUidCheck)
	end

	if CurAvatar and isCustom == false and uid == CurAvatar.uid then
		local needRefresh = self._checkForceTime(uid)

		if needRefresh == true then
			self.getMyHeadTexture(true, nil)
		end
	end
end

function HeadHelper.getHeadID(normalId)
	local headInfo = ResRoleHead[normalId]

	if headInfo then
		if headInfo.atlas_path and headInfo.icon_path then
			return "Atlas/" .. headInfo.atlas_path, headInfo.icon_path
		elseif headInfo.heroid then
			local heroInfo = ResHero[tonumber(headInfo.heroid)]

			if heroInfo then
				local commonInfo = ResCommonModel[heroInfo.model]

				if commonInfo and commonInfo.head_path and commonInfo.head_name then
					return "Atlas/" .. commonInfo.head_path, commonInfo.head_name
				end
			end
		end
	end
end

function HeadHelper.setDefaultIcon(image)
	if image == nil then
		return
	end

	image:setImage("Atlas/PlayerInforAtlas/PlayerInforAtlas", "BgHeadDefault")
	image:setVisible(true)
end

function HeadHelper.forceSetCustomHead(displayUI)
	if displayUI then
		local data = self._getSaveData()
		local path = data.path

		if data.status == Const.CUSTOM_HEAD_STATUS.UP_LOAD_FAILD then
			ClientUtils.record.headStatus = Const.CUSTOM_HEAD_STATUS.UP_LOAD_FAILD
		end

		if self._isHeadOk() then
			displayUI:setImageWithTexture(ClientUtils.record.headTexture)

			return
		end

		if path and path ~= "" then
			local tex = ServerDownloadUtils.LoadLocalTextureByFile(path)

			if tex then
				displayUI:setImageWithTexture(tex)

				return
			end
		end

		self.setDefaultIcon(displayUI)
	end
end

function HeadHelper.isPosted(...)
	local data = self._getSaveData()
	local path = data.path

	if (not path or path == "") and ClientUtils.record.headStatus == Const.CUSTOM_HEAD_STATUS.NOT_FIND then
		return false
	else
		return true
	end
end

function HeadHelper._getSaveData(...)
	if self.saveData then
		return self.saveData
	end

	self.saveData = {}

	local data = UserData.loadCommonData(SAVE_PREFIX .. CurAvatar.uid)

	if data and data ~= "" then
		self.saveData = utils.unserialize(data)
	end

	return self.saveData
end

function HeadHelper._saveData(path, status)
	self.saveData = self.saveData or {}
	self.saveData.path = path or self.saveData.path
	self.saveData.status = status

	UserData.saveCommonData(SAVE_PREFIX .. CurAvatar.uid, utils.serialize(self.saveData))
end

function HeadHelper.setCustomHead(image, headId, uid, needUidCheck)
	local isOk = false

	if CurAvatar and uid == CurAvatar.uid and ClientUtils.record.headTexture and ClientUtils.record.headValid then
		image:setImageWithTexture(ClientUtils.record.headTexture)
		image:setVisible(true)

		isOk = true
	end

	if not isOk then
		local needRefresh = self._checkForceTime(uid)

		if CurAvatar and uid == CurAvatar.uid and needRefresh then
			self.getMyHeadTexture(true, self._refreshMainMenuHead)
		end

		if needUidCheck then
			ServerDownloadUtils.displayHeadWithUidCheck(uid, headId, image, image, not needRefresh)
		else
			ServerDownloadUtils.displayWebImage(Const.DOMAIN_HEAD, uid, headId, image, nil, not needRefresh)
		end
	end
end

function HeadHelper._refreshMainMenuHead(...)
	if CurAvatar then
		CurAvatar:refreshNameUI()
	end
end

function HeadHelper.isNeedLoginRefresh(callBack)
	if self.isPostedSuccess() == false then
		ClientUtils.record.headStatus = Const.CUSTOM_HEAD_STATUS.NOT_FIND

		return false
	end

	local resKey = ServerDownloadUtils.formatHeadResKey(CurAvatar.uid, self.getMyCustomId())

	if ServerDownloadUtils.isTextureCached(resKey) then
		ServerDownloadUtils.loadFromCache(resKey, Functor(HeadHelper._getHeadCallBack, callBack))

		return true
	end

	if not self._isHeadOk() then
		self.getMyHeadTexture(true, callBack)

		return true
	end

	return false
end

function HeadHelper._isHeadOk(...)
	local ok = ClientUtils.record.headStatus == Const.CUSTOM_HEAD_STATUS.DOWN_OK and ClientUtils.record.headTexture ~= nil and ClientUtils.record.headValid == true

	return ok
end

function HeadHelper.getMyHeadTexture(forceServer, callBack)
	forceServer = true

	if forceServer or ClientUtils.record.headTexture == nil then
		ClientUtils.record.headValid = false

		if forceServer then
			self.deleteMyCache()
		end

		ServerDownloadUtils.getHeadFromWeb(CurAvatar.uid, self.getMyCustomId(), Functor(HeadHelper._getHeadCallBack, callBack), not forceServer)
	end
end

function HeadHelper.deleteMyCache(...)
	ServerDownloadUtils.releaseLoader(CurAvatar.uid, self.getMyCustomId())
end

function HeadHelper._refreshMyHeadCallBack(displayUI)
	if displayUI and displayUI.uid == CurAvatar.uid then
		if ClientUtils.record.headTexture and ClientUtils.record.headValid then
			displayUI:setImageWithTexture(ClientUtils.record.headTexture)
		else
			self.setDefaultIcon(displayUI)
		end
	else
		self.setDefaultIcon(displayUI)
	end

	CurAvatar:refreshNameUI()
	CurAvatar:refreshRoleInfoUI()
end

function HeadHelper._getHeadCallBack(callBack, code, texture, errorMsg)
	if CurAvatar == nil then
		return
	end

	local result = self.refreshMyHeadDownStatus(code, errorMsg)

	if code == Const.WEB_REQ_STATE_CODE.SUCCESS then
		if result == true then
			ClientUtils.record.headValid = true
			ClientUtils.record.headTexture = texture
		end

		if callBack then
			callBack()
		end
	elseif callBack then
		callBack()
	end
end

function HeadHelper.refreshMyHeadPostStatus(code, status)
	if code == nil then
		ClientUtils.record.headStatus = Const.CUSTOM_HEAD_STATUS.UP_LOADING
	elseif code == Const.WEB_REQ_STATE_CODE.SUCCESS then
		if status == Const.POST_STATUS.OK then
			ClientUtils.record.headStatus = Const.CUSTOM_HEAD_STATUS.POST_OK
		elseif status == Const.POST_STATUS.REVIEWING or status == Const.POST_STATUS.WILL_REVIEW then
			ClientUtils.record.headStatus = Const.CUSTOM_HEAD_STATUS.REVIEWING
		elseif status == Const.POST_STATUS.FAIL then
			ClientUtils.record.headStatus = Const.CUSTOM_HEAD_STATUS.FORBID
		end
	elseif code == Const.WEB_REQ_STATE_CODE.UNKNOWN then
		ClientUtils.record.headStatus = Const.CUSTOM_HEAD_STATUS.UP_LOAD_FAILD

		if status == Const.POST_STATUS.TOO_BIG then
			MsgManager.notice(Lang.get(30749))
		end
	else
		ClientUtils.record.headStatus = Const.CUSTOM_HEAD_STATUS.UP_LOAD_FAILD
	end

	self._saveData(nil, ClientUtils.record.headStatus)
end

function HeadHelper.refreshMyHeadDownStatus(code, msg)
	local respMsg = ClientUtils.string2Table(msg or "")

	if code == Const.WEB_REQ_STATE_CODE.SUCCESS and msg ~= "" then
		if respMsg and respMsg.code then
			if respMsg.code == Const.CUSTOM_HEAD_STATUS.REVIEWING then
				ClientUtils.record.headStatus = Const.CUSTOM_HEAD_STATUS.REVIEWING
			elseif respMsg.code == Const.CUSTOM_HEAD_STATUS.FORBID then
				ClientUtils.record.headStatus = Const.CUSTOM_HEAD_STATUS.FORBID
			elseif respMsg.code == Const.CUSTOM_HEAD_STATUS.NOT_FIND then
				ClientUtils.record.headStatus = Const.CUSTOM_HEAD_STATUS.NOT_FIND
			else
				ClientUtils.record.headStatus = Const.CUSTOM_HEAD_STATUS.DOWN_OK
			end
		else
			ClientUtils.record.headStatus = Const.CUSTOM_HEAD_STATUS.DOWN_OK
		end
	else
		ClientUtils.record.headStatus = Const.CUSTOM_HEAD_STATUS.NOT_FIND
	end

	return ClientUtils.record.headStatus == Const.CUSTOM_HEAD_STATUS.DOWN_OK
end

function HeadHelper.getOwnHead(...)
	local data = {}
	local heroId

	for i, headInfo in pairs(ResRoleHead) do
		heroId = headInfo.heroid

		if heroId then
			if CurAvatar.handBookHeroDic[tonumber(heroId)] then
				table.insert(data, headInfo)
			end
		elseif i ~= Const.PERSONAL_HEAD_ID then
			table.insert(data, headInfo)
		elseif CurAvatar.headIds[i] == true then
			table.insert(data, headInfo)
		end
	end

	return data
end

function HeadHelper.getOwnHeadFrame(...)
	local data = {}

	for id, v in pairs(CurAvatar.headFrameIds) do
		local item = ResItem[id]

		if item then
			table.insert(data, item)
		end
	end

	return data
end

function HeadHelper.getOwnHeadPendant(...)
	local data = {}

	for id, v in pairs(CurAvatar.headPendantIds) do
		local item = ResRoleHeadPendant[id]

		if item then
			table.insert(data, item)
		end
	end

	return data
end

function HeadHelper.getOwnChatBubble()
	local data = {}

	for id, v in pairs(CurAvatar.chatBubbleIds) do
		local item = ResRoleChatBubble[id]

		if item then
			table.insert(data, item)
		end
	end

	return data
end

function HeadHelper._checkForceTime(uid)
	if CurAvatar and uid == CurAvatar.uid then
		if self.isPostedSuccess() == false then
			return false
		end

		if ClientUtils.record.headStatus == Const.CUSTOM_HEAD_STATUS.REVIEWING and os.time() - checkHeadTime > self.getPullInterval(true) then
			checkHeadTime = os.time()

			return true
		end
	elseif self.getTimeMap[uid] then
		if os.time() - self.getTimeMap[uid] > self.getPullInterval(false) then
			self.getTimeMap[uid] = os.time()

			return true
		end
	else
		self.getTimeMap[uid] = os.time()

		return true
	end

	return false
end

function HeadHelper.setDelayCheckTime(...)
	checkHeadTime = os.time() + 5 - self.getPullInterval(true)
end

function HeadHelper.getMyCustomHeadStatus(callBacK)
	if os.time() - checkHeadTime > self.getPullInterval(true) then
		checkHeadTime = os.time()

		ServerDownloadUtils.getHeadFromWeb(CurAvatar.uid, self.getMyCustomId(), function(code, tex, msg)
			self.refreshMyHeadDownStatus(code, msg)

			if callBack then
				callBack(CurAvatar.status)
			end
		end, false)
	elseif callBack then
		callBack(CurAvatar.status)
	end
end

function HeadHelper.getPullInterval(isSelf)
	if isSelf == true then
		return Const.CHECK_HEAD_STATUS_INTERVAL
	else
		return Const.CHECK_HEAD_OTHER_INTERVAL + math.random(60)
	end
end

function HeadHelper.setHeadById(displayUI, headId)
	if headId == 0 then
		headId = Const.DEFAULT_HEAD
	end

	if displayUI then
		if headId == Const.PERSONAL_HEAD_ID then
			if ClientUtils.record.headTexture then
				displayUI:setImageWithTexture(ClientUtils.record.headTexture)
			else
				self.setDefaultIcon(displayUI)
			end
		elseif ResRoleHead[headId] then
			local headInfo = ResRoleHead[headId]

			displayUI:setImage("Atlas/" .. headInfo.atlas_path, headInfo.icon_path)
		end
	end
end

function HeadHelper.pickImage(callBack, uiCallBack, subResId)
	local SDKAppUtils = require("SDK/SDKAppUtils")

	SDKAppUtils.pickImage(1, 1, 500, 500, "jpg", function(isSuccess, path)
		if isSuccess then
			local function yesFunc(...)
				self.refreshMyHeadPostStatus(nil)

				local data = {}

				data.path = path
				data.status = ClientUtils.record.headStatus

				self._saveData(path, ClientUtils.record.headStatus)

				if uiCallBack then
					uiCallBack()
				end

				ServerDownloadUtils.uploadHead(path, callBack, subResId)
			end

			local msgContent = string.format(Lang.get(30744), ClientUtils.CeilToDayOrHour(Const.POST_HEAD_INTERVAL))

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", msgContent, yesFunc, nil, nil)
		end
	end)
end

function HeadHelper.getHintByStatus(status)
	if status == nil then
		return
	end

	if status == Const.CUSTOM_HEAD_STATUS.NOT_FIND and self.isPosted() then
		status = Const.CUSTOM_HEAD_STATUS.UP_LOAD_FAILD
	end

	return HEAD_STATUS_HINT[status]
end

function HeadHelper.setHeadFrame(displayUI, headFrameId, endTime)
	headFrameId = headFrameId == 0 and Const.DEFAULT_HEAD_FRAME_ID or headFrameId

	if endTime and endTime > 0 and endTime < ClientUtils.getServerTime() then
		headFrameId = Const.DEFAULT_HEAD_FRAME_ID
	end

	if displayUI then
		local isShow = true

		if headFrameId == Const.DEFAULT_HEAD_FRAME_ID then
			displayUI:setImage("Atlas/CommonAtlas/HeadFrameAtlas/HeadFrameAtlas01", "HeadFrame00")

			if displayUI.effectChild then
				displayUI.effectChild:setVisible(false)
			end
		else
			local item = ResItem[headFrameId]

			if item then
				local info = ResRoleHeadFrame[headFrameId]

				if info then
					displayUI:setImage("Atlas/CommonAtlas/HeadFrameAtlas/" .. info.icon_path, info.icon_name)
				end

				if displayUI.headFrameId == headFrameId then
					if displayUI.effectChild then
						displayUI.effectChild:setVisible(true)
					end
				else
					if displayUI.effectChild then
						displayUI.effectChild:destroy()

						displayUI.effectChild = nil
					end

					if info and info.effect_path then
						displayUI.effectChild = UIControls.Child(displayUI, displayUI.mPath, info.effect_path)

						if UIControls.checkControlFunc(displayUI.effectChild, "", UIConst.ControlTypeUIAni) then
							displayUI.effectChild.aniCom = UIControls.UIAni(displayUI.effectChild, "")

							local data = utils.splitString(info.effect_path, "/")

							if data then
								displayUI.effectChild.aniName = "Loop" .. data[#data]
							end
						end

						displayUI.effectChild:setVisible(true)
					end
				end
			else
				isShow = false
			end
		end

		displayUI.headFrameId = headFrameId

		displayUI:setVisible(isShow)
	end
end

function HeadHelper.getHeadFrameInfoById(headFrameId)
	return ResRoleHeadFrame[headFrameId]
end

return HeadHelper
