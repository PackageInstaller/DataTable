--核心兑换详情
local data={
    {id=1,stars=3,first={card=false,gets={10033,1}},second={card=true,gets={10034,5}},third={card=true,gets={10034,5}}},
    {id=1,stars=4,first={card=false,gets={10033,1}},second={card=true,gets={10034,30}},third={card=true,gets={10034,30}}},
    {id=1,stars=5,first={card=false,gets={10033,1}},second={card=true,gets={10033,5}},third={card=true,gets={10033,8}}},
    {id=1,stars=6,first={card=false,gets={10033,1}},second={card=true,gets={10033,10}},third={card=true,gets={10033,15}}},
}
local data2={
    {id=1,stars=3,gets={10034,5}},
    {id=1,stars=4,gets={10033,1}},
    {id=1,stars=5,gets={10033,5}},
    {id=1,stars=6,gets={10033,10}},
}

------自选构建信息
local data3={
    {id=1,stars=3,first={card=false,gets={10053,10}},second={card=true,gets={10053,1}},third={card=true,gets={10053,1}}},
    {id=1,stars=4,first={card=false,gets={10053,10}},second={card=true,gets={10053,5}},third={card=true,gets={10053,5}}},
    {id=1,stars=5,first={card=false,gets={10053,10}},second={card=true,gets={10053,50}},third={card=true,gets={10053,50}}},
    {id=1,stars=6,first={card=false,gets={10053,10}},second={card=true,gets={10053,100}},third={card=true,gets={10053,100}}},
}
local data4={
    {id=1,stars=3,gets={10053,1}},
    {id=1,stars=4,gets={10053,80}},
    {id=1,stars=5,gets={10053,8}},
    {id=1,stars=6,gets={10053,200}},
}
local items={};
local items2={};
function OnOpen()
    local list1=openSetting==2 and data3 or data
    local list2=openSetting==2 and data4 or data2
    ItemUtil.AddItems("Shop/CoreExchangeItem", items, list1, layout1, nil, 1);
    ItemUtil.AddItems("Shop/CoreExchangeItem3", items2, list2, layout2, nil, 1);
end

function OnClickClose()
    view:Close();
end