-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\LoginHelper.lua

local UserData = require("Helper/UserData")
local VersionUtils = require("System/VersionUtils")
local ResClientHardCode = require("ClientData/ResClientHardCode")
local Analytics = require("SDK/Analytics")
local HeadHelper = require("UI/RoleInfo/HeadHelper")
local SDKConst = require("SDK/SDKConst")
local LoginState = SDKConst.LoginState
local LoginHelper = {}
local AGREEMENT_STORAGE = {
	isNotStorage = "false",
	isStorage = "true"
}
local self = LoginHelper

function LoginHelper.Init()
	self.loginDlg = UIManager.tryGetUI("login")
end

function LoginHelper.updateAgreement()
	local agreement = UserData.loadCommonData(Const.UD_KEY_AGREEMENT)

	if agreement == AGREEMENT_STORAGE.isStorage then
		self.setAgreementSwitch(true, true)
	elseif agreement == AGREEMENT_STORAGE.isNotStorage then
		self.setAgreementSwitch(false, true)
	else
		local defaultOn = VersionUtils.isAgreementAcceptedDefault()

		self.setAgreementSwitch(defaultOn)
	end
end

function LoginHelper.setAgreementSwitch(isOn, ignoreCallback)
	if ignoreCallback then
		self._agreementCallbackIgnored = true

		if self.loginDlg then
			self.setAgreementIsOn(isOn)
		end

		self._agreementCallbackIgnored = false
	elseif self.loginDlg then
		self.setAgreementIsOn(isOn)
	end
end

function LoginHelper.onAgreementPopSelected(agree)
	if RegionUtils.isCN() and Const.IGNORE_POP_AGREEMENT_CALLBACK then
		-- block empty
	else
		self.setAgreementSwitch(agree)
	end

	self.tryShowNotice()
end

function LoginHelper.tryShowNotice()
	if not VersionUtils.IsReviewVersion() then
		local state = GameFsm.getState(Const.STATE_LOGIN)

		if state then
			state:checkLoginNotice()
		end
	end
end

function LoginHelper.tryShowAgreementOnOpen()
	local hasPopUp = false

	if RegionUtils.isJP() then
		local showAgreement = UserData.loadCommonData("showAgreementIndex")

		if ResClientHardCode[11] then
			local agreementIdx = tonumber(ResClientHardCode[11].value[1])

			if tonumber(showAgreement) ~= agreementIdx then
				UserData.saveCommonData("showAgreementIndex", tostring(agreementIdx))
				SDKAgent.openAgreement()

				hasPopUp = true
			end
		end
	elseif RegionUtils.isKR() then
		-- block empty
	elseif RegionUtils.isSEA() then
		-- block empty
	elseif RegionUtils.isTW() then
		-- block empty
	elseif RegionUtils.isCN() and VersionUtils.getEngineVersion() < 250000 and not ChannelUtil.isQQGame() then
		local showAgreement = UserData.loadCommonData("showAgreementIndex")

		if ResClientHardCode[11] then
			local agreementIdx = tonumber(ResClientHardCode[11].value[2])

			if tonumber(showAgreement) ~= agreementIdx then
				UserData.saveCommonData("showAgreementIndex", tostring(agreementIdx))
				SDKAgent.openAgreement()

				hasPopUp = true
			end
		end
	end

	if not hasPopUp then
		self.tryShowNotice()
	end
end

function LoginHelper.onAgreementSelectChanged()
	if self._agreementCallbackIgnored then
		return
	end

	local isOn = self.loginDlg and self.loginDlg.getAgreementIsOn() or false

	self.setAgreementIsOn(not isOn)

	isOn = self.loginDlg and self.loginDlg.getAgreementIsOn()

	if isOn then
		local loginState = AccountManager.getLoginState()

		if loginState == LoginState.UNLOGIN and RegionUtils.isJP() then
			SDKAgent.login()
		end
	end
end

function LoginHelper.setAgreementIsOn(isOn)
	if isOn then
		UserData.saveCommonData(Const.UD_KEY_AGREEMENT, AGREEMENT_STORAGE.isStorage)
	else
		UserData.saveCommonData(Const.UD_KEY_AGREEMENT, AGREEMENT_STORAGE.isNotStorage)
	end

	self._agreementCallbackIgnored = true

	if self.loginDlg and self.loginDlg.setAgreementIsOn then
		self.loginDlg:setAgreementIsOn(isOn)
	end

	self._agreementCallbackIgnored = false
end

function LoginHelper.loginBuriedPoint(succ, startConnTime)
	if RegionUtils.isJP() then
		local data = Analytics.getByteLogParamNoUser()

		data.event = "guide_flow"
		data.guide_id = succ and 160 or 1001
		data.duration = os.time() - startConnTime

		Analytics.sendLogByted("guide_flow", ClientUtils.table2String(data))
	end
end

function LoginHelper.split(str, reps)
	local resultStrList = {}

	string.gsub(str, "[^" .. reps .. "]+", function(w)
		table.insert(resultStrList, w)
	end)

	return resultStrList
end

function LoginHelper.headBuriedPoint(isLogin)
	if RegionUtils.isJP() and CurAvatar then
		local customId, normalId, flag = HeadHelper.decodeHeadInfo(CurAvatar.head)
		local url, head_path

		if flag then
			local resKey = string.format("%s_%s", CurAvatar.uid, customId)

			url = SvrListManager.getFileSvr():Get() .. "/head/" .. resKey
		else
			head_path, url = HeadHelper.getHeadID(normalId)

			local strs = self.split(head_path, "/")

			if strs then
				head_path = strs[#strs]
			end

			url = string.format("%s/%s", head_path, url)
		end

		local data = Analytics.getByteSendLogPubParameter()

		data.event = "profile_flow"
		data.action = isLogin and 1 or 0
		data.profile_url = url

		Analytics.sendLogByted("profile_flow", ClientUtils.table2String(data))
	end
end

return LoginHelper
