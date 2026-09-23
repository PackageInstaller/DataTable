local items = nil
local enStrs = {"O N E","T W O", "T H R E E","F O U R","F I V E","S I X","S E V E N","E I G H T","N I N E"}
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
	SetItems()
end

function SetNode()
	-- CSAPI.SetGOActive(nol,not isSpecial)
	-- CSAPI.SetGOActive(nextImg, isNextDay)
	-- CSAPI.SetGOActive(spec, isSpecial)
	CSAPI.SetGOActive(get, isDone)
    CSAPI.SetGOActive(cur,isCurDay and not isDone)
	SetRed(isCurDay and not isDone)

	CSAPI.SetText(txtDay,index < 10 and "0" .. index or index.."")
    if index < 10 then
        CSAPI.SetText(txtDay2,enStrs[index])
    end

    local id = 71007
    local alpha = 0.6
    if isDone then
        id = 1050
        alpha= 1
    elseif isCurDay then
        id = 6011
        alpha= 1
    end
    LanguageMgr:SetText(txtReward,id)
    LanguageMgr:SetEnText(txtReward2,id)
    CSAPI.SetGOAlpha(txtReward,alpha)
    CSAPI.SetGOAlpha(txtReward2,alpha)
end

function SetRed(b)
	UIUtil:SetRedPoint(redParent,b)
end

function SetItems()
	local rewards = data:GetRewards() or {}
	items = items or {}
	ItemUtil.AddItems("SignInContinue9/SignInAnniversary1Item2",items,rewards,grid,nil,1,{isSpecial = isSpecial})
	CSAPI.SetAnchor(grid,-5,#rewards > 1 and 153 or 65)
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
