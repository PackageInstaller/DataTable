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
	local isCurNotDone = isCurDay and not isDone
	CSAPI.SetGOActive(nol,not isSpecial and not isCurNotDone)
	CSAPI.SetGOActive(nextImg, isNextDay)
	CSAPI.SetGOActive(spec, isSpecial and not isCurNotDone)
	CSAPI.SetGOActive(get, isDone)
	CSAPI.SetGOActive(cur,isCurNotDone)
	SetRed(isCurNotDone)

	local imgName1 = "img_"
	imgName1 = index < 10 and imgName1 .. "0" .. index .."_" or imgName1.. index .."_"
	local imageName2 = isDone and "03" or "01"
	CSAPI.LoadImg(dayImg,"UIs/SignInContinue4/" ..imgName1..imageName2..".png",true,nil,true)
end

function SetRed(b)
	UIUtil:SetRedPoint(redParent,b)
end

function SetItems()
	local rewards = data:GetRewards() or {}
	items = items or {}
	ItemUtil.AddItems("SignInContinue4/SignInShadowSpiderItem2",items,rewards,grid,nil,1,{isSpecial = isSpecial})
	CSAPI.SetAnchor(grid,-15,#rewards > 1 and 217 or 108)
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
