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
	SetItems()
end

function SetNode()
	CSAPI.SetGOActive(nol,not isSpecial)
	CSAPI.SetGOActive(nextImg, isNextDay)
	CSAPI.SetGOActive(spec, isSpecial)
	CSAPI.SetGOActive(get, isDone)
	SetRed(isCurDay and not isDone)

	LanguageMgr:SetText(txtDay,22016,StringUtil:NumberToString(index))
	local color = isSpecial and {140,30,0,255} or {170,99,12,255}
	CSAPI.SetOutlineColor(txtDay,color[1],color[2],color[3],color[4])
end

function SetRed(b)
	UIUtil:SetRedPoint(redParent,b)
end

function SetItems()
	local rewards = data:GetRewards() or {}
	items = items or {}
	ItemUtil.AddItems("SignInContinue6/SignInZhongQiuItem2",items,rewards,grid,nil,1,{isSpecial = isSpecial})
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
