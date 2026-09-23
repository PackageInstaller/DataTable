--占位表对象,该类用来记录当前布局内容中每个坐标的占位信息
local this = {}

function this.New(x, y)
	this.__index = this.__index or this;
	local ins = {};
	ins.posTab = {}; --占位表
	for i = 1, x do
		ins.posTab[i] = {}
	end
	ins.maxX = x; --X最大坐标
	ins.maxY = y;--Y最大坐标
	setmetatable(ins, this);	
	return ins;
end

--设置哪些格子只有指定的卡牌才能放置，格式：{{row=1,col=1,cfgId=1},...}
function this:SetForceTab(_forceTab)
	self.forceTab=_forceTab;
	if self.forceTab then
		local currSexCard=RoleMgr:GetCurrSexCardCfgId();
		for k,v in ipairs(self.forceTab) do
			if RoleMgr:IsSexInitCardIDs(v.cfgId) then
				v.cfgId=currSexCard;
			end
		end
	end
end

--记录卡牌占位信息teamItemData:TeamItemData
function this:AddCardPosInfo(teamItemData)
	local coord = teamItemData:GetHolderInfo();--获取卡牌的相对坐标
	--计算绝对坐标并记录占位信息
	for k1, v1 in ipairs(coord) do
		local r = teamItemData.row + v1[1] - 1;
		local c = teamItemData.col + v1[2] - 1;
		self.posTab[r] [c] = teamItemData;
	end
end

--根据坐标删除占位信息
function this:RemoveCardPosInfo(x, y)
	if self.posTab[x] [y] ~= nil then
		self.posTab[x] [y] = nil;
	end
end

--根据cid返回卡牌占位的格子坐标集合
function this:GetCardRealCoord(cid)
	local pos={};
	for x = 1, self.maxX do
		for y = 1, self.maxY do
			local item=self:GetPosData(x,y);
			if item and item.cid==cid then
				table.insert(pos,{row=x,col=y});
			end
		end
	end
	return pos;
end

--根据cid返回占位信息
function this:GetPosDataByCid(cid)
	if cid~=nil and cid~="" then
		for x=1,self.maxX do
			for y=1,self.maxY do
				local item =self:GetPosData(x,y);
				if item~= nil and item.cid==cid then
					return item;
				end
			end
		end
	end
	return nil;
end

function this:GetPosDataByRoleTag(roleTag)
	if roleTag~=nil and roleTag~="" then
		for x=1,self.maxX do
			for y=1,self.maxY do
				local item =self:GetPosData(x,y);
				if item~= nil and item:GetRoleTag()==roleTag then
					return item;
				end
			end
		end
	end
	return nil;
end

--删除卡牌占位信息
function this:RemoveCard(teamItemData)
	if teamItemData then
		local coord =teamItemData:GetHolderInfo();--获取卡牌的相对坐标
		--计算绝对坐标并删除
		for k1, v1 in ipairs(coord) do
			local r = teamItemData.row + v1[1] - 1;
			local c = teamItemData.col + v1[2] - 1;
			if self.posTab[r] [c] ~= nil and self.posTab[r] [c].cid == teamItemData.cid then
				self.posTab[r] [c] = nil;
			end
		end
	end
end

--判断占用范围坐标是否被占用,被占用的话会返回字典型数组 [被占用的卡牌ID]=teamItemData
function this:HasRecord(x, y,cid,coord)
	--计算绝对坐标
	local hasCard = false;
	local id = nil;
	for k1, v1 in ipairs(coord) do
		local r = x + v1[1] - 1;
		local c = y + v1[2] - 1;
		if(self.posTab[r] [c] ~= nil and self.posTab[r] [c].cid ~= cid) then
			id = id == nil and {} or id;
			local record = self:GetPosData(r, c);
			id[record.cid] = record;
			hasCard = true;
		end
	end
	return hasCard, id;
end

--判断占用范围的坐标是否超出范围
function this:IsOutLine(x, y, coord)
	--计算绝对坐标
	local isOut = false;
	for k1, v1 in ipairs(coord) do
		local r = x + v1[1] - 1;
		local c = y + v1[2] - 1;
		if(r < 1 or r > self.maxX or c < 1 or c > self.maxY) then
			isOut = true;
		end
	end
	return isOut;
end

--返回占位的数据
function this:GetPosData(x, y)
	if x > 0 and x <= self.maxX and y > 0 and y <= self.maxY then
		return self.posTab[x] [y];
	end
	return nil;
end

--设置item的新位置
function this:SetItemPos(teamItem,newRow,newCol)
	self:RemoveCard(teamItem);
	teamItem.row=newRow;
	teamItem.col=newCol;
	self:AddCardPosInfo(teamItem);
end

--返回空格数量
function this:GetNullGridNum()
	local num = 0;
	for x = 1, self.maxX do
		for y = 1, self.maxY do
			if self.posTab[x] [y] == nil then
				num = num + 1;
			end
		end
	end
	return num;
end

-- --返回当前的所有空位置
-- function this:GetNullPos()
--     local nullPos=nil;
--     for x=1,self.maxX do
--         for y=1,self.maxY do
--             if self.posTab[x][y]==nil then
--                 nullPos=nullPos or {};
--                 table.insert(nullPos);
--             end
--         end
--     end
--     return nullPos;
-- end

--是否是合体者 0表示不是合体者，1表示是合体发动者，2表示是被合体者
function this:IsUnite(itemData)
	if itemData == nil then
		return 0;
	end
	local upCard, downCard, leftCard, rightCard = nil,nil,nil,nil;
	upCard = self:GetPosData(itemData.row + 1, itemData.col);
	downCard = self:GetPosData(itemData.row - 1, itemData.col);
	leftCard = self:GetPosData(itemData.row, itemData.col + 1);
	rightCard = self:GetPosData(itemData.row, itemData.col - 1);
	local fitState=itemData:GetFitDirection();
	--获取合体方向
	if fitState ~= - 1 then
		local list = nil;
		if fitState == 1 then
			list = {};
			table.insert(list, upCard);
			table.insert(list, downCard);
		elseif fitState == 2 then
			list = {};
			table.insert(list, leftCard);
			table.insert(list, rightCard);
		elseif fitState == 3 then
			list = {};
			table.insert(list, upCard);
			table.insert(list, downCard);
			table.insert(list, leftCard);
			table.insert(list, rightCard);
		end
		if self:GetInUnite(itemData, list) then
			return 1;
		end
	else
		local upFit=upCard~=nil and upCard:GetFitDirection() or -1;
		local downFit=downCard~=nil and downCard:GetFitDirection() or -1;
		local leftFit=leftCard~=nil and leftCard:GetFitDirection() or -1;
		local rightFit=rightCard~=nil and rightCard:GetFitDirection() or -1;
		if(upCard and(upFit == 1 or upFit == 3) and self:GetInUnite(upCard, {itemData})) then
			return 2;
		elseif(downCard and(downFit == 1 or downFit == 3) and self:GetInUnite(downCard, {itemData})) then
			return 2;
		elseif(leftCard and(leftFit == 2 or leftFit == 3) and self:GetInUnite(leftCard, {itemData})) then
			return 2;
		elseif(rightCard and(rightFit == 2 or rightFit == 3) and self:GetInUnite(rightCard, {itemData})) then
			return 2;
		end
	end
	return 0;
end

--判断是否合体
function this:GetInUnite(item1, items)
	local isIn = false;
	if item1 and items then
		for k, v in ipairs(items) do
			local isInUnite=item1:IsUnite(v:GetCfgID());
			if(v and item1:GetGrids() == v:GetGrids() and isInUnite) then
				isIn = true;
				break
			end
		end
	end
	return isIn;
end

--==============================--
--desc:返回合体范围内的坐标
--time:2019-06-11 02:15:52
--@teamItem:合体发起者
--@fitState:合体方向
--@return 
--==============================--
function this:GetFitRange(teamItem, fitState)
	local list = nil;
	local upPos, downPos, leftPos, rightPos = nil,nil,nil,nil;
	upPos = {row = teamItem.row + 1, col = teamItem.col};
	downPos = {row = teamItem.row - 1, col = teamItem.col};
	leftPos = {row = teamItem.row, col = teamItem.col + 1};
	rightPos = {row = teamItem.row, col = teamItem.col - 1};
	if fitState ~= - 1 then
		if fitState == 1 then
			list = {};
			table.insert(list, upPos);
			table.insert(list, downPos);
		elseif fitState == 2 then
			list = {};
			table.insert(list, leftPos);
			table.insert(list, rightPos);
		elseif fitState == 3 then
			list = {};
			table.insert(list, upPos);
			table.insert(list, downPos);
			table.insert(list, leftPos);
			table.insert(list, rightPos);
		end
	end
	return list;
end

--==============================--
--desc:返回可以合体的卡牌的占位数据信息
--time:2019-06-11 05:06:14
--@cid:要对比的卡牌ID
--@hasFit:返回结果中是否包含已有合体对象的占位数据,默认包含
--@return 
--==============================--
function this:GetFitItem(cid, hasFit)
	local hasFit = hasFit == nil and true or hasFit;
	local list = nil;
	local card = FormationUtil.FindTeamCard(cid);
	local arr = self:GetArray();
	if arr==nil then
		Log(self.posTab);
	end
	for k, v in ipairs(arr) do
		if card:IsInUnite(v:GetCfgID()) or v:IsUnite(card:GetCfgID()) then
			if hasFit == true or(hasFit == false and self:IsUnite(v) == 0) then
				list = list or {};
				table.insert(list, v);
			end
		end
	end
	return list;
end

--放置卡牌，返回是否成功 成功时返回坐标row和col
function this:TryPushCard(cid,grids)
	--匹配占位
	local formationType = FormationUtil.GetFormationType(grids);
	local allPos = FormationUtil.GetCardCanMovePos(formationType);
	local holderInfo = FormationUtil.GetPlaceHolderInfo(grids);
	local isSuccess = false;
	local position = nil;
	for _, pos in ipairs(allPos) do--遍历所有可以放置的点
		if self:GetPosData(pos[1], pos[2]) == nil and self:HasRecord(pos[1], pos[2],cid, holderInfo) == false  then
			--匹配新位置成功
			position = position or {};
			position.row = pos[1];
			position.col = pos[2];
			isSuccess = true;
			break
		end
	end
	return isSuccess, position;
end

--放置卡牌到指定位置 isReplace:是否允许删除当前位置的卡牌 isTry:为true时不会保存站位表
function this:PushCardByPos(teamItemData,isReplace,isTry)
	--匹配占位
	local formationType =teamItemData:GetFormationType();
	local holderInfo = teamItemData:GetHolderInfo();
	local isSuccess = false;
	local doReplace=false;
	local posData=self:GetPosData(teamItemData.row, teamItemData.col);
	--检测要放置的位置是否是强制位置
	local canPush=self:CanMoveToForceGrid(teamItemData.cid,holderInfo,teamItemData.row, teamItemData.col)
	if posData then
		local isFriendCard=false;
		if FormationUtil.IsFirendCardID(teamItemData:GetID()) or teamItemData:IsAssist() then
			isFriendCard=true;
		end
		local posIsAssist=false;
		if FormationUtil.IsFirendCardID(posData:GetID()) or posData:IsAssist() then
			posIsAssist=true;
		end
		--检查是否是普通队员卡替换支援位置
		-- Log(tostring(isFriendCard).."\t"..tostring(posIsAssist));
		if isFriendCard~=posIsAssist then
			return false,false;
		end
	end	
	if canPush then --能放置再执行操作
		if isReplace then
			local tempTab=FormationTable.New(self.maxX, self.maxY);
			tempTab.posTab=self:ReturnCopyPosTab();
			tempTab:SetForceTab(self.forceTab);
			if posData then
				doReplace=true;
				tempTab:RemoveCard(posData);
			end
			if self:IsOutLine(teamItemData.row, teamItemData.col,holderInfo)==false and tempTab:HasRecord(teamItemData.row, teamItemData.col,teamItemData:GetID(), holderInfo) == false then --占位范围内没有重叠且没有越界
				if isTry~=true then
					tempTab:AddCardPosInfo(teamItemData);
					self.posTab=tempTab:ReturnCopyPosTab();
					self:SetForceTab(tempTab.forceTab);
				end
				isSuccess = true;
			end
		else
			if posData == nil and self:IsOutLine(teamItemData.row, teamItemData.col,holderInfo)==false and self:HasRecord(teamItemData.row, teamItemData.col,teamItemData:GetID(), holderInfo) == false then
				--放置成功
				if isTry~=true then
					self:AddCardPosInfo(teamItemData);
				end
				isSuccess = true;
			end
		end
	end
	return isSuccess,doReplace;
end

--交换两个卡牌的位置 只匹配空位置是否够放，不改变其他卡牌位置
function this:ReplaceCard(cid,cid2)
	local card1=self:GetPosDataByCid(cid);
	local card2=self:GetPosDataByCid(cid2);
	if card1==nil or card2==nil then
		return false;
	end
	local tempTab=FormationTable.New(self.maxX, self.maxY);
	tempTab.posTab=self:ReturnCopyPosTab();
	tempTab:SetForceTab(self.forceTab);
	tempTab:RemoveCard(card1);
	tempTab:RemoveCard(card2);
	local r=card1.row;
	local c=card1.col;
	card1.row=card2.row;
	card1.col=card2.col;
	card2.row=r;
	card2.col=c;
	local isSuccess=false;
	local isSuccess2=false;
	local canMoveToForce=tempTab:CanMoveToForceGrid(card1.cid,card1:GetHolderInfo(),card1.row,card1.col);
	local canMoveToForce2=tempTab:CanMoveToForceGrid(card2.cid,card1:GetHolderInfo(),card2.row,card2.col);
	if tempTab:GetPosData(card1.row, card1.col) == nil and tempTab:HasRecord(card1.row, card1.col,card1:GetID(), card1:GetHolderInfo()) == false and canMoveToForce  then
		tempTab:AddCardPosInfo(card1);
		isSuccess=true;
	end
	if tempTab:GetPosData(card2.row, card2.col) == nil and tempTab:HasRecord(card2.row, card2.col,card2:GetID(), card2:GetHolderInfo()) == false and canMoveToForce2 then
		tempTab:AddCardPosInfo(card2);
		isSuccess2=true;
	end
	if isSuccess and isSuccess2 then
		self.posTab=tempTab:ReturnCopyPosTab();
		self:SetForceTab(tempTab.forceTab);
		return true;
	end
end

--尝试放置队员（优先放置到item中的row和col，如果该位置被占用则自动匹配新位置，无法放置返回false）
function this:TryPushTeamItemData(teamItemData)
	local canPush=false;
	local pos=nil
	if teamItemData then
		local hasRecord=self:HasRecord(teamItemData.row, teamItemData.col,teamItemData.cid,teamItemData:GetHolderInfo());
		if not hasRecord then
			canPush=true;
			pos={
				row=teamItemData.row,
				col=teamItemData.col,
			};
		else
			canPush, pos = self:TryPushCard(teamItemData.cid,teamItemData:GetGrids());
		end
	end
	return canPush,pos;
end

--尝试移动卡牌后是否可以放置卡牌
function this:TryMovePushCard(teamItem)
	-- local card=FormationUtil.FindTeamCard(teamItem.cid);
	local grids=teamItem:GetGrids();
	--匹配占位
	local formationType = teamItemData:GetFormationType();
	local allPos = FormationUtil.GetCardCanMovePos(formationType);
	local holderInfo = teamItem:GetHolderInfo();
	local info = nil;
	--逐个查找自身可放置的点，然后删除占用目标格子的物体，待放入新物体后再尝试将被删除的物体添加回来
	for _, position in ipairs(allPos) do
		local items = nil;
		local backUp = self:ReturnCopyPosTab();
		for key, val in ipairs(holderInfo) do
			local x = position[1] + val[1] - 1;
			local y = position[2] + val[2] - 1;
			local item = self:GetPosData(x, y);
			if item and(items == nil or items[item.cid] == nil) then
				items = items or {};
				items[item.cid] = item;
				self:RemoveCard(item);
			end
		end
		local isOk = true;
		teamItem.row=position[1];
		teamItem.col=position[2];
		self:AddCardPosInfo(teamItem);
		if items then
			for key, val in pairs(items) do
				local isSuccess2, pos2 = self:TryPushCard(val.cid,val:GetGrids());
				if isSuccess2 == false then
					isOk = false;
					break;
				else
					val.row=pos2.row;
					val.col=pos2.col;
					self:AddCardPosInfo(val);
				end
			end
		end
		if isOk == true then
			Log("放置成功！");
			return true;
		else
			self.posTab = backUp;
		end
	end
	--特殊情况
	--判断当前放置的物体是否是两个横的，两个竖的，一个1点的，是的话按模板放置
	local array = self:GetArray() or {};
	if array==nil then
		Log(self.posTab);
	end
	local screenByType = {};
	local typeX = 0;--横向两个的物体个数
	local typeY = 0;--纵向两个的物体个数
	local typeO = 0;--单格物体的个数
	local isOK2 = true;
	local backUp2 = self:ReturnCopyPosTab();
	for k, v in ipairs(array) do
		local tempGrids = v:GetGrids();
		local formatType = v:GetFormationType();
		screenByType[formatType] = screenByType[formatType] or {};
		table.insert(screenByType[formatType], {id=v.cid,grids=tempGrids,bIsNpc=v.bIsNpc,data=v});
		self:RemoveCard(v);
		if formatType == FormationType.HDouble then
			typeX = typeX + 1;
		elseif formatType == FormationType.VDouble then
			typeY = typeY + 1;
		elseif formatType == FormationType.Single then
			typeO = typeO + 1;
		end
	end
	if formationType == FormationType.HDouble then
		typeX = typeX + 1;
	elseif formationType == FormationType.VDouble then
		typeY = typeY + 1;
	elseif formationType == FormationType.Single then
		typeO = typeO + 1;
	end
	--放入当前要插入的物体
	screenByType[formationType] = screenByType[formationType] or {};
	table.insert(screenByType[formationType],{id=teamItem.cid,grids=grids,bIsNpc=bIsNpc,data=teamItem} );
	--开始放置
	if typeX == 2 and typeY == 2 and typeO == 1 then
		for i = 1, 5 do
			local item = nil;
			if i == 3 then
				item = screenByType[FormationType.Single] [1];
			else
				local index=i>3 and i-1 or i;
				if index % 2 == 0 then
					item = screenByType[FormationType.HDouble] [index / 2];
				else
					item = screenByType[FormationType.VDouble] [(index+1 ) / 2];
				end
			end
			local isSuccess2, pos2 = self:TryPushCard(item.cid,item.grids);
			if isSuccess2 == false then
				self.posTab = backUp2;
				isOK2 = false;
				break;
			else
				if item.data then
					local teamItemData3=nil;
					teamItemData3=item.data;
					teamItemData3.col=pos2.col;
					teamItemData3.row=pos2.row;
					self:AddCardPosInfo(teamItemData3);
				else
					LogError("编队出错！插入的卡牌成员不能为nil");
					self.posTab = backUp2;
					return false;
				end
			end
		end
	else
		self.posTab = backUp2;
		isOK2 = false;
	end
	return isOK2;
end


--判断卡牌是否可以移动到指定位置
function this:CanMove(cid,newRow,newCol)
	local canMove=false;
	local tempTab=FormationTable.New(self.maxX, self.maxY);
	tempTab.posTab=self:ReturnCopyPosTab();
	tempTab:SetForceTab(self.forceTab);
	local teamItem=tempTab:GetPosDataByCid(cid);
	local oldRow=teamItem.row;
	local oldCol=teamItem.col;
	local coord=teamItem:GetHolderInfo();
	local canMoveToForce=tempTab:CanMoveToForceGrid(cid,coord,newRow,newCol);
	if teamItem and not tempTab:IsOutLine(newRow,newCol,coord) and canMoveToForce then
		local item2=tempTab:GetPosData(newRow,newCol);
		local hasRecord,recordList=tempTab:HasRecord(newRow, newCol,cid,coord);
		local recordNum=0;
		if recordList then
			for k,v in pairs(recordList) do
				recordNum=recordNum+1;
			end
		end
		--判断新位置上是否已经存在卡牌
		if(item2 ~= nil and cid == item2.cid and hasRecord == false) or(item2 == nil and hasRecord == false) then
			--当前位置没有占位信息,将卡牌设置到新位置
			tempTab:SetItemPos(teamItem,newRow,newCol);
			canMove=true;
		elseif item2 ~= nil and cid ~= item2.cid and teamItem:GetGrids() == item2:GetGrids() and hasRecord == true and recordNum==1 then
			--同一占位类型进行移动
			tempTab:SetItemPos(teamItem,item2.row,item2.col);
			tempTab:SetItemPos(item2,oldRow,oldCol);
			canMove=true;
		elseif recordList then
			--判断不同类型的占位是否可以移动
			local moveList = {};
			--移除被占用的卡牌的旧位置
			for k, v in pairs(recordList) do
				tempTab:RemoveCard(v);
				table.insert(moveList, {cid=v.cid,grids = v:GetGrids(), data = v});
			end
			--记录拖拽卡牌的新位置
			tempTab:SetItemPos(teamItem,newRow,newCol);
			table.sort(moveList, FormationUtil.SortInfoByType);
			--匹配新位置
			local moveSuccess=true;
			for k, v in ipairs(moveList) do
				local isSuccess, pos = tempTab:TryPushCard(v.cid,v.grids);
				if isSuccess then
					local data=TeamItemData.New();
					data:SetData(v.data:GetFormatData());
					data.row = pos.row;
					data.col = pos.col;
					tempTab:AddCardPosInfo(data);
				else
					--无法放置
					moveSuccess = false;
					break;
				end		
			end
			canMove=moveSuccess;
		end
	end
	return canMove,tempTab;
end

--判断可否移动到强制位置
function this:CanMoveToForceGrid(cid,coord,row,col)
	local canMove=true;
	if self.forceTab then
		local card=FormationUtil.FindTeamCard(cid);
		local cfgId=card:GetCfgID();
		local hasForce=false;
		for k,v in ipairs(self.forceTab) do --强制的卡牌只能在范围内移动
			if v.cfgId==cfgId then
				hasForce=true;
				canMove=false;
				break;
			end
		end
		for k,v in ipairs(coord) do
			local r = row + v[1] - 1;
			local c = col + v[2] - 1;
			for _,val in ipairs(self.forceTab) do
				if val.row==r and val.col==c and cfgId~=val.cfgId and hasForce==false then--非强制卡牌无法放到强制位置
					canMove=false;
					break;
				elseif hasForce==true and cfgId==val.cfgId and val.row==r and val.col==c then
					canMove=true;
					break;
				end
			end
		end
	end
	return canMove
end

--返回站位数组
function this:GetArray()
	local tab = nil;
	local arr = nil;
	for x = 1, self.maxX do
		for y = 1, self.maxY do
			if self.posTab ~= nil then
				tab = tab or {};
				local data = self.posTab[x] [y];
				if data ~= nil then
					tab[data.cid] = data;
				end
			end
		end
	end
	for _, v in pairs(tab) do
		arr = arr or {};
		-- if v.index~=nil then
		-- 	table.insert(arr,v.index,v);
		-- else
			table.insert(arr, v);
		-- end
	end
	return arr;
end

function this:ReturnCopyPosTab()
	local temp = {};
	for x=1,self.maxX do
		temp[x]={};
		for y=1,self.maxY do
			local item =self:GetPosData(x,y);
			if item~= nil then
				local tempItem=TeamItemData.New();
				tempItem:SetData(item:GetFormatData());
				temp[x][y]=tempItem;
			end
		end
	end
	return temp
end

function this:Log()
	Log("-----------------FormationTable  Log--------------------");
	local list={};
	for x=1,self.maxX do
		for y=1,self.maxY do
			local item =self:GetPosData(x,y);
			if item~= nil then
				table.insert(list,{key=x.."-"..y,item=item:GetFormatData()});
			end
		end
	end
	Log(list);
	Log("-----------------FormationTable  LogEnd--------------------");
end

return this; 