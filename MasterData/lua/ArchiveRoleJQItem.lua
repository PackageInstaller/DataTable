--剧情item
local StoryData = require "StoryData"

--CRoleStoryInfo
function Refresh(_data)
	data = _data
	stroyData = SetStoryData(data:GetStoryId())
	if(data and stroyData) then
		lock = data:GetIsLock()
		success = data:GetIsSuccess()
		
		CSAPI.SetText(txtName, stroyData:GetStoryName())
		SetIcon()
		SetReward()
		SetLock()
		CSAPI.SetGOActive(new, not lock and not success)
		if(not canvasGroup) then
			canvasGroup = ComUtil.GetCom(node, "CanvasGroup")
		end
		canvasGroup.alpha = lock and 0.3 or 1
	end
end

--数据
function SetStoryData(storyID)
	local _storyData = StoryData.New();
	_storyData:InitCfg(storyID);
	return _storyData
end

function SetIcon()
	local iconName = data:GetIconName()
	if(iconName) then
		ResUtil.StoryIcon:Load(icon, iconName,false) 
	end
end

function SetReward()
	local rewards = data:GetRewards()
	if(rewards) then
		CSAPI.SetGOActive(objGet, success)
		CSAPI.SetGOActive(itemParent, true)
		local reward = rewards[1]
		local result, clickCB = GridFakeData(reward)
		if(lReward) then
			CSAPI.SetGOActive(lReward.gameObject, true)
		else
			local _go, _lReward = ResUtil:CreateGridItem(rewardParent.transform)
			lReward = _lReward
		end
		lReward.Refresh(result)
		lReward.SetClickCB(clickCB);
		lReward.SetCount(reward.num)
	else
		CSAPI.SetGOActive(objGet, false)
		CSAPI.SetGOActive(itemParent, false)
	end
end

function SetLock()
	CSAPI.SetGOActive(mask, lock)
	if(lock) then
		CSAPI.SetText(txtLock, data:GetLockStr())	
	end
end


--播放剧情
function OnClick()
	local id = data:GetStoryId()
	if(not lock and id) then
		CSAPI.OpenView("Plot", {storyID = id, playCallBack = PlayCallBack})
	else
		Tips.ShowTips(StringTips.common1)
	end
end

--播放回调
function PlayCallBack()
	if(not success) then
		PlayerProto:PassCardRoleStory(data:GetCRoleId(), data:GetIndex())
	end
end




function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
node=nil;
icon=nil;
txtName=nil;
rewardParent=nil;
objGet=nil;
new=nil;
mask=nil;
txtLock=nil;
view=nil;
end
----#End#----