local mTab = nil
local curIndex = 0
local isUnLock = false

function Awake()
	mTab = ComUtil.GetCom(tab, "CTab")
	mTab:AddSelChangedCallBack(OnTabChanged)
	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Exploration_Open_Ret, RefreshPanel)

	fade = ComUtil.GetCom(gameObject, "ActionFade")
end

function OnTabChanged(index)
	curIndex = index
	RefreshPanel()
end

function Refresh(data)
	RefreshPanel()
end

function RefreshPanel()
	local color1 = curIndex == 0 and {255, 193, 70, 255} or {255, 255, 255, 255}
	local color2 = curIndex == 1 and {255, 193, 70, 255} or {255, 255, 255, 255}
	CSAPI.SetTextColor(txt1, color1[1], color1[2], color1[3], color1[4])
	CSAPI.SetTextColor(txt2, color2[1], color2[2], color2[3], color2[4])
	
	LanguageMgr:SetText(txtDesc1, curIndex == 0 and 22009 or 22011)
	LanguageMgr:SetText(txtDesc2, curIndex == 0 and 22010 or 22012)
	
	isUnLock = ExplorationMgr:GetCurrState() and ExplorationMgr:GetCurrState() > ExplorationState.Normal or false
	
	CSAPI.SetGOActive(lockImg, not isUnLock)
	CSAPI.SetGOActive(unLockImg, isUnLock)
	CSAPI.SetGOActive(btnUnLock, not isUnLock)
	
	--time
	-- local timeInfo = ActivityMgr:GetActivityTime()
	-- CSAPI.SetText(txtTime, "")
end

function OnClickUnLock()
	-- CSAPI.OpenView("ExplorationBuy")
	UIUtil:OpenExplorationBuy()
end

function OnClickJump()
	CSAPI.OpenView("ExplorationMain")
end 

function PlayFade(isFade,cb)
	local star = isFade and 1 or 0
	local target = isFade and 0 or 1
	fade:Play(star,target,200,0,function ()
		if cb then
			cb()
		end
	end)
end

function OnDestroy()
	eventMgr:ClearListener()
end