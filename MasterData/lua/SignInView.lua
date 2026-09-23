local SignInInfo = require "SignInInfo"
local weekStr = {"MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY","SUNDAY"}
local isSignIn = false
local curDayInfo = nil
local curItem = nil
local isSelect = false
local key = nil
local cfg = nil
local isFillStart = false
local cfgFillGood = nil
local costNum = 0
local isCostEnough = false

function Awake()
	-- UIUtil:AddTop2("SignInView", top, OnClickClose)
	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Activity_SignIn, ESignCB)
	fade = ComUtil.GetCom(gameObject, "ActionFade")
	
	CSAPI.PlayUISound("ui_popup_open")	
end

function OnDestroy()
	eventMgr:ClearListener()
	ReleaseCSComRefs()
end

function Refresh(_data,_elseData)
	CSAPI.PlayUISound("ui_popup_open")	
    data = _data
    if data then
        key = SignInMgr:GetDataKeyById(data:GetID())
        cfg = data:GetCfg()
        local info = SignInMgr:GetDataByKey(key)
		isSignIn = info and not info:CheckIsDone()
        if isSignIn then
            EventMgr.Dispatch(EventType.Activity_Click)
        end
		RefreshPanel()

		if isSignIn then
			isSelect = true
			curItem.SetSelect(true)
			if not rightItemFade then
				rightItemFade = ComUtil.GetCom(rewardObj, "ActionFade")
			end
			rightItemFade:Play(0, 1, 1000, 0, function()
				isSelect = false
			end)
		end
    end
end

function Update()
	--下一次签到倒计时
	local timeData= TimeUtil:GetTimeHMS(TimeUtil:GetBJTime())
	local time = (TimeUtil:GetNextDay(timeData) +(g_ActivityDiffDayTime * 3600)) - TimeUtil:GetBJTime()
	time = time > 86400 and time- 86400 or time
	local timeStr = TimeUtil:GetTimeStr(time)
	LanguageMgr:SetText(txtNext, 13006, timeStr)
end

function RefreshPanel()
	SetLeft()
	SetRight()
end

function SetLeft()
	SetItems()
	
	--时间
	local tab = TimeUtil:GetTimeHMS(TimeUtil:GetBJTime())
	local month = tab.month
	if tab.day == 1 and tab.hour < g_ActivityDiffDayTime then
		month = month - 1
	end
	LanguageMgr:SetText(txtTime, 13004, month)
	local week = TimeUtil:GetWeekDay2(TimeUtil:GetBJTime())
	CSAPI.SetText(txtWeek, weekStr[week])
end

function SetItems()
	local isClear = false
	key = CheckCurKey()
	local infos = SignInMgr:GetDayInfos(key)	
	local signInfo = SignInMgr:GetDataByKey(key)
	isFillStart = signInfo:CheckIsFillStart()
	if infos == nil then --无任何数据重新封装获取
		local tab = TimeUtil:GetTimeHMS(TimeUtil:GetBJTime())
		local proto = {
			id = tonumber(tab["year"]),
			index= tonumber(tab["month"]),
			rewardsInfos = {
				index = 1,
				indexs ={}
			}
		}
		SignInMgr:GetSignInfoRet(proto)
		infos = SignInMgr:GetDayInfos(key)	
		isClear = true
	end
	if(infos) then
		if curItem then
			curItem.SetSelect(false)
		end
		SetCurDayInfo(infos)
		items = items or {}
		for i = 1, 35 do
			local info = nil	
			if i <= #infos then
				info = infos[i]
			end
			if(i <= #items) then
				items[i].Refresh(info,{isClear = isClear,isFill = isFillStart})
				if items[i].IsCurDay() then
					curItem = items[i]
				end
			else
				ResUtil:CreateUIGOAsync("SignIn/SignInItem", grid, function(go)
					local item = ComUtil.GetLuaTable(go)
					item.SetClickCB(OnItemClickCB)
					item.Refresh(info,{isClear = isClear,isFill = isFillStart})
					if item.IsCurDay() then
						curItem = item
					end
					table.insert(items, item)
				end)
			end			
		end
	end
end

--跨月或跨年检测 更新当前界面信息
function CheckCurKey()
	local tab = TimeUtil:GetTimeHMS(TimeUtil:GetBJTime())
	local h = tonumber(tab["hour"])
	if h >= g_ActivityDiffDayTime then
		local curKey = tab["year"] .."_" .. tab["month"]
		if curKey ~= key then
			return curKey
		end
	end
	return key
end

--获取当天签到信息
function SetCurDayInfo(_infos)
	for i, v in ipairs(_infos) do
		if v.isCurDay then
			curDayInfo = v
			break
		end
	end
end

function OnItemClickCB(item)
	if curItem then
		curItem.SetSelect(false)
	end

	curItem = item
	curItem.SetSelect(true)
	curDayInfo = item.IsShowRight() and curItem.data or nil
	SetRight()
end

function SetRight()
	--右边物品
	if curDayInfo then
		CSAPI.SetGOActive(btnSign,true)
		local num = curDayInfo:GetRewards() [1] [2]
		CSAPI.SetText(txtNum, "X" .. num)
		local goodsData = curDayInfo:GetGoodsData()		
		CSAPI.LoadImg(rewardObj, "UIs/SignIn/rightImg" .. goodsData:GetQuality() .. ".png", true, nil, true)
		LoadIcon(goodsData)
		CSAPI.SetText(txtName, goodsData:GetName())
		
		--已签到
		local isDone = curDayInfo:CheckIsDone()		
		local isCurDay = curDayInfo:GetIsCurDay()
		CSAPI.SetGOActive(signImg1, isDone)
		CSAPI.SetGOActive(signImg2, not isDone)
		local color = isDone and {255, 255, 255, 178} or {0, 0, 0, 255}
		CSAPI.SetTextColor(txt_sign, color[1], color[2], color[3], color[4])
		-- CSAPI.SetTextColor(txt_sign2, color[1], color[2], color[3], color[4])
		local id = isDone and 13008 or 13007
		CSAPI.SetGOActive(fillObj,isFillStart and not isDone and not isCurDay)
		if isFillStart and not isCurDay then
			SetFill()
		end
		LanguageMgr:SetText(txt_sign, id)
		-- CSAPI.SetText(txt_sign2, isDone and "SIGNED IN" or "SIGN IN")
	else
		CSAPI.SetGOActive(btnSign,false)
	end	
end

--加载图标
function LoadIcon(goodsData)
	CSAPI.SetGOActive(icon, goodsData ~= nil);
	if(goodsData) then
		goodsData:GetIconLoader():Load(icon, goodsData:GetIcon() .. "")
	end
end

function SetFill()
	local signInfo = SignInMgr:GetDataByKey(key)
	local cfg = signInfo:GetCfg()
	if cfg and cfg.MuCheckin_Cost then
		local reward = cfg.MuCheckin_Cost[1]
		costNum = reward[2]
		cfgFillGood = Cfgs.ItemInfo:GetByID(reward[1])
		if cfgFillGood and cfgFillGood.icon then
			ResUtil.IconGoods:Load(costIcon,cfgFillGood.icon .. "_1")
		end
		CSAPI.SetText(txtCost,costNum .. "")
		isCostEnough = BagMgr:GetCount(cfgFillGood.id) >= costNum
		local code = isCostEnough and "ffffff" or "fa3838"
		CSAPI.SetTextColorByCode(txtCost, code)
	end
	CSAPI.SetGOActive(fillNum,signInfo:IsShowFillNum())
	CSAPI.SetText(txtFillNum,signInfo:GetFillNum() .. "")
end

--签到回调
function ESignCB(proto)
	local _key = SignInMgr:GetDataKey(proto.id, proto.index)
	if(key ~= _key) then
		return
	end
	if proto.isOk == false then
		EventMgr.Dispatch(EventType.Acitivty_List_Pop)
        return
    end
    SignInMgr:AddCacheRecord(key)

	--if(proto.isOk) then
	-- CSAPI.SetGOActive(mask, false)
	RefreshPanel()--刷新列表
	ActivityMgr:CheckRedPointData(ActivityListType.SignIn)

	local taData = {
		reson = "领取活动奖励",
		activity_name = "每日活动",
		task_id = proto.id,
		task_name = proto.index,
		item_gain = rewards
	}
	if CSAPI.IsADV()==false then
		BuryingPointMgr:TrackEvents("activity_attend", taData)
	end
end

function OnClickSign()
	if not isFillStart or not curItem or not curItem.data or curItem.isDone then
		return
	end
	if not isCostEnough then
		LanguageMgr:ShowTips(74004)
		return 
	end
	local info = SignInMgr:GetDataByKey(key)
	if info:GetFillNum() <= 0 then
		LanguageMgr:ShowTips(74002)
		return
	end
	local dialogData = {}
	dialogData.content = LanguageMgr:GetTips(74001,cfgFillGood.name .. "x" .. costNum)  .. (info:IsShowFillNum()
	and "\n" .. LanguageMgr:GetTips(74003,info:GetFillNum()) or "")
	dialogData.okCallBack = function()
		SignIn(curItem.data:GetIndex())
	end
	CSAPI.OpenView("Dialog",dialogData)
end

--自动签到
function OnClickMask()
	SignIn()
end

function SignIn(index)
	local data = SignInMgr:GetDataByKey(key)
	ClientProto:AddSign(data:GetID(),index)
	
	if(data) then
		local rewards = {}
		for i, info in pairs(data:GetRewardCfg().infos) do
			if(i == data:GetIndex()) then
				for k, m in pairs(info.rewards) do
					table.insert(rewards, {id = m[1], num = m[2]})
				end
			end
		end	
	end
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

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	imgObj = nil;
	txtTime = nil;
	week = nil;
	txtWeek = nil;
	next = nil;
	txtNext = nil;
	grid = nil;
	right = nil;
	rewardObj = nil;
	icon = nil;
	txtNum = nil;
	txtName = nil;
	btnSign = nil;
	signImg1 = nil;
	signImg2 = nil;
	txt_sign = nil;
	txt_sign2 = nil;
	mask = nil;
	view = nil;
end
----#End#----
