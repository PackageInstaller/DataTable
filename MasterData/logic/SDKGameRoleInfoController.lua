-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sdk/controller/SDKGameRoleInfoController.lua

module("logic.extensions.rune.model.SDKGameRoleInfoController", package.seeall)

local SDKGameRoleInfoController = class("SDKGameRoleInfoController", BaseController)

function SDKGameRoleInfoController:ctor()
	return
end

function SDKGameRoleInfoController:onInit()
	self:onReset()
end

function SDKGameRoleInfoController:createRole()
	local roleInfo = self:getRoleInfo()

	roleInfo.type = 1

	SDKManager.createRole(roleInfo)
end

function SDKGameRoleInfoController:enterGame()
	local roleInfo = self:getRoleInfo()

	roleInfo.type = 2

	SDKManager.enterGame(roleInfo)
end

function SDKGameRoleInfoController:onRoleLevelUp()
	local roleInfo = self:getRoleInfo()

	roleInfo.type = 3

	SDKManager.upgradeRole(roleInfo)
end

function SDKGameRoleInfoController:getRoleInfo()
	local loginTime = math.floor(RoleModel.instance:getLoginTime() / 1000)
	local activeTime = math.floor(RoleModel.instance:getActiveTime() / 1000)
	local lastLogoutTime = math.floor(RoleModel.instance:getLoginOutTime() / 1000)
	local lastLogoutTimeFmt

	loginTime = GameUtil.formatTimeStamp("%Y-%m-%d %H:%M:%S", loginTime)

	local myFamilyInfo = FamilyModel.instance:getMyFamilySettingInfo()
	local maxChapId, maxStageId = PlotCopyModel.instance:getCurMaxProgress()

	maxChapId = maxChapId - 1000

	local var_6_0 = {
		roleId = tostring(RoleModel.instance:getUserId()),
		roleName = RoleModel.instance:getUserName(),
		roleLevel = checknumber(MofangModel.instance:getCurLv()),
		serverId = tostring(LoginModel.instance.curAreaStatus.id)
	}

	var_6_0.serverName = tostring(LoginModel.instance.curAreaStatus.name or "")
	var_6_0.roleCTime = activeTime
	var_6_0.loginTime = loginTime
	var_6_0.lastLogoutTime = (lastLogoutTime > 0 or nil) and GameUtil.formatTimeStamp("%Y-%m-%d %H:%M:%S", lastLogoutTime)
	var_6_0.registerTime = activeTime

	local var_6_1 = {
		balancename = "神钻",
		roleType = "",
		pointValue = "",
		chapter = string.format("%d-%d", maxChapId, maxStageId),
		combatValue = tostring(RoleModel.instance:getMaxPower())
	}

	if myFamilyInfo then
		var_6_1.partyName = myFamilyInfo.familyName or ""
	end

	var_6_1.gameVipLevel = tostring(VipModel.instance:getCurVipLv())
	var_6_1.gameMoney = tostring(MaterialModel.instance:getMaterialsNumber(MatType.GodGem, 0))
	var_6_0.ext = var_6_1

	return var_6_0
end

SDKGameRoleInfoController.instance = SDKGameRoleInfoController.New()

return SDKGameRoleInfoController
