local items = nil
--SignInfDayInfo
function Refresh(_data, _isShowNextDay)
	isShowNextDay = _isShowNextDay
	data = _data
	id = data.id
	if(not id) then
		return --空数据
	end
	
	index = data:GetIndex() or 1 --天
	isDone = data:CheckIsDone() --已签
	isCurDay = data:GetIsCurDay() --是否是当天
	isNextDay = data:GetIsNextDay() and isShowNextDay --是否是下一天
	isSpecial = data:GetSpecial() ~= nil
		
	SetNode()
	SetColor()
	SetItems()
end

function SetNode()
	CSAPI.SetGOActive(nol,not isSpecial)
	CSAPI.SetGOActive(nextImg, isNextDay)
	CSAPI.SetGOActive(spec, isSpecial)
	CSAPI.SetGOActive(get, isDone)
	SetRed(isCurDay and not isDone)

	CSAPI.SetText(txtDay,index < 10 and "0" .. index or index .. "")
end

function SetColor()
	local color = {255,255,255,255}

    if isSpecial then
		color= {45,46,53,255}
	end
	CSAPI.SetTextColor(txtName,color[1],color[2],color[3],color[4])
end

function SetRed(b)
	UIUtil:SetRedPoint(redParent,b)
end

function SetItems()
	local rewards = data:GetRewards() or {}
	items = items or {}
	ItemUtil.AddItems("RegressionActivity1/RegressionSignItem2",items,rewards,grid,nil,1)
    if rewards and rewards[1] then
        local cfg = Cfgs.ItemInfo:GetByID(rewards[1][1])
        if cfg then
            CSAPI.SetText(txtName, cfg.name)
        end
    end
end

function OnDestroy()	
	ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	bg = nil;
	node = nil;
	itemParent = nil;
	icon = nil;
	doneImg = nil;
	num1 = nil;
	num2 = nil;
	view = nil;
end
----#End#----
