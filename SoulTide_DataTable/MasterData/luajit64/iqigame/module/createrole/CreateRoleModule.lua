-- chunkname: @IQIGame\\Module\\CreateRole\\CreateRoleModule.lua

CreateRoleModule = {
	CreateRoleDiaLog3 = 2011000055,
	CreateRoleDiaLog1 = 2011000000,
	CreateRoleDiaLog2 = 2011000010,
	isJump = false,
	CreateState = 0,
	CreateRoleDiaLog4 = 38011050,
	CreateRoleMovie2 = {
		{
			"21_Media/CG/Prologue/Prologue_2.mp4",
			false
		}
	},
	playDialogs = {}
}

function CreateRoleModule.AddEventListener()
	CreateRoleModule.RemoveEventListener()
	EventDispatcher.AddEventListener(EventID.CloseDialogUI, CreateRoleModule.OnEndDialogEvent)
	EventDispatcher.AddEventListener(EventID.PlayVideoEnd, CreateRoleModule.OnEndVideoEvent)
	EventDispatcher.AddEventListener(EventID.CloseSoulUnlockUI, CreateRoleModule.OnCloseSoulUnlockEvent)
end

function CreateRoleModule.RemoveEventListener()
	EventDispatcher.RemoveEventListener(EventID.CloseDialogUI, CreateRoleModule.OnEndDialogEvent)
	EventDispatcher.RemoveEventListener(EventID.PlayVideoEnd, CreateRoleModule.OnEndVideoEvent)
	EventDispatcher.RemoveEventListener(EventID.CloseSoulUnlockUI, CreateRoleModule.OnCloseSoulUnlockEvent)
end

function CreateRoleModule.ChangeCreateRole(index)
	if index == 0 then
		CreateRoleModule.CreateState = 1
	elseif index == 1 then
		CreateRoleModule.CreateState = 2
	end

	if not CreateRoleModule.isJump then
		CreateRoleModule.AddEventListener()

		if index == 0 then
			CreateRoleModule.PlayDialog(CreateRoleModule.CreateRoleDiaLog2)
		end
	end
end

function CreateRoleModule.StartCreateRole()
	CreateRoleModule.CreateState = 0
	CreateRoleModule.isJump = false
	CreateRoleModule.playDialogs = {}

	CreateRoleModule.AddEventListener()
	UIModule.Close(Constant.UIControllerName.LoginUI)

	CreateRoleModule.CreateRoleMovie1 = PrologueVideoUIApi:GetString("CreateRoleMovie1")
	CreateRoleModule.CreateRoleText1 = PrologueVideoUIApi:GetString("CreateRoleText1")
	CreateRoleModule.CreateRoleSound1 = PrologueVideoUIApi:GetString("CreateRoleSound1")

	UIModule.Open(Constant.UIControllerName.PrologueVideoUI, Constant.UILayer.UI, {
		CreateRoleModule.CreateRoleMovie1,
		1,
		CreateRoleModule.CreateRoleText1,
		CreateRoleModule.CreateRoleSound1
	})
end

function CreateRoleModule.OpenLotteryUI()
	UIModule.Open(Constant.UIControllerName.CreteRoleEffectUI, Constant.UILayer.UI)
end

function CreateRoleModule.PlayDialog(dialogCid)
	UIModule.Close(Constant.UIControllerName.LoginUI)

	if table.indexOf(CreateRoleModule.playDialogs, dialogCid) == -1 then
		DialogModule.OpenDialog(dialogCid)
		table.insert(CreateRoleModule.playDialogs, dialogCid)
	end
end

function CreateRoleModule.CreateRoleResult(role)
	PlayerModule.PlayerInfo.baseInfo.pName = role.pname

	CreateRoleModule.PlayDialog(CreateRoleModule.CreateRoleDiaLog2)
	UIModule.Close(Constant.UIControllerName.InputPlayerNameTextUI)

	CreateRoleModule.CreateState = 1
	CreateRoleModule.isJump = false
end

function CreateRoleModule.OnEndDialogEvent(dialogCid)
	if dialogCid == CreateRoleModule.CreateRoleDiaLog1 then
		UIModule.Open(Constant.UIControllerName.InputPlayerNameTextUI, Constant.UILayer.UI)
	elseif dialogCid == CreateRoleModule.CreateRoleDiaLog2 then
		UIModule.Open(Constant.UIControllerName.PrologueUI, Constant.UILayer.UI)
	elseif dialogCid == CreateRoleModule.CreateRoleDiaLog3 then
		UIModule.Open(Constant.UIControllerName.PrologueVideoUI, Constant.UILayer.UI, {
			CreateRoleModule.CreateRoleMovie2,
			2
		})
	elseif dialogCid == CreateRoleModule.CreateRoleDiaLog4 then
		CreateRoleModule.CreateRoleEndEnterGame()
	end
end

function CreateRoleModule.OnEndVideoEvent(index)
	if CreateRoleModule.isJump then
		return
	end

	if index == 1 then
		CreateRoleModule.PlayDialog(CreateRoleModule.CreateRoleDiaLog1)
	elseif index == 2 then
		UIModule.Open(Constant.UIControllerName.SoulUnlockUI, Constant.UILayer.UI, {
			[UIParam.soulUnlockUI.soulIds] = {
				CfgDiscreteDataTable[6507098].Data[1]
			},
			[UIParam.soulUnlockUI.type] = 2,
			[UIParam.soulUnlockUI.index] = 1
		})
	end
end

function CreateRoleModule.OnCloseSoulUnlockEvent(type, index)
	if type == 2 and index == 1 then
		CreateRoleModule.CreateState = 2

		CreateRoleModule.HandselSoul()
		CreateRoleModule.PlayDialog(CreateRoleModule.CreateRoleDiaLog4)
	end
end

function CreateRoleModule.CreateRoleEndEnterGame()
	CreateRoleModule.RemoveEventListener()
	net_player.loadPlayer()
end

function CreateRoleModule.JumpCreateRole()
	CreateRoleModule.isJump = true

	UIModule.Close(Constant.UIControllerName.PrologueVideoUI)
	UIModule.Close(Constant.UIControllerName.DialogUI)
	UIModule.Close(Constant.UIControllerName.SoulUnlockUI)

	if CreateRoleModule.CreateState == 0 then
		UIModule.Open(Constant.UIControllerName.InputPlayerNameTextUI, Constant.UILayer.UI)
	elseif CreateRoleModule.CreateState == 1 then
		CreateRoleModule.HandselSoul()
		CreateRoleModule.CreateRoleEndEnterGame()
	elseif CreateRoleModule.CreateState == 2 then
		CreateRoleModule.CreateRoleEndEnterGame()
	end
end

function CreateRoleModule.CreateRole(name)
	SDKLoginModule.LogCreateRole(1)
	SDKLoginModule.checkDirtyWords(name, function(contain, replaceContent)
		if contain then
			NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, SettingPlayerInfoViewApi:GetString("ErrorMsg3"))

			return
		end

		net_user.createRole(1000, name)
	end)
end

function CreateRoleModule.HandselSoul()
	net_user.handselSoul()
end

function CreateRoleModule.HandselSoulResult(handselSoulCount)
	CreateRoleModule.ChangeCreateRole(handselSoulCount)
end

function CreateRoleModule.Shutdown()
	CreateRoleModule.RemoveEventListener()
end
