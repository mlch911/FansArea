//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var areas = ["闵行区莘庄镇","兰州七里河区","三明市尤溪县","西宁城西区","广州白云区","闽侯县上街镇","哈尔滨市南岗区","临汾市尧都区","成都武侯区","汕头市金平区","长沙市芙蓉区"]
var provinces = ["上海","甘肃","福建","青海","广东","福建","黑龙江","山西","四川","广东","湖南"]
var parts = ["华东","西北","东南","西北","华南","东南","东北","华北","西南","华南","华中"]
var areaImages = ["baiyun","chengxi","furong","jinping","nangang","qilihe","shangjie","wuhou","xining","xinzhuang","yaodu","youxi"]
var visited = [Bool](repeatElement(false, count: 11))

for i in 0..<areas.count {
    print("Area(name: \"\(areas[i])\", province: \"\(provinces[i])\", part: \"\(parts[i])\", image: \"\(areaImages[i])\", isvisited: false),")
}

//Area(name: "闵行区莘庄镇疏影路711弄东苑新天地21号405", province: "上海", part: "华东", image: "xinzhuang", isvisited: false),
//Area(name: "兰州七里河区彭家坪路36号兰州理工大学西校区计算机系", province: "甘肃", part: "西北", image: "qilihe", isvisited: false),
//Area(name: "三明市尤溪县东旭佳园83号楼", province: "福建", part: "东南", image: "youxi", isvisited: false),
//Area(name: "西宁城西区香格里拉路昆仑阳光城5号楼，近新华巷", province: "青海", part: "西北", image: "chengxi", isvisited: false),
//Area(name: "广州白云区黄石东路江夏东二街200号", province: "广东", part: "华南", image: "baiyun", isvisited: false),
//Area(name: "闽侯县上街镇工贸路惠好路福禄坊", province: "福建", part: "东南", image: "shangjie", isvisited: false),
//Area(name: "哈尔滨市南岗区蒿山路125号中植方州苑1102", province: "黑龙江", part: "东北", image: "nangang", isvisited: false),
//Area(name: "临汾市尧都区解放东路与尧贤路交汇处恒安新东城逸景40栋3001", province: "山西", part: "华北", image: "yaodu", isvisited: false),
//Area(name: "成都武侯区丽都路2号置信丽都花园15号1004", province: "四川", part: "西南", image: "wuhou", isvisited: false),
//Area(name: "汕头市金平区汕樟路16号（中山路与汕樟路转角）凯悦华庭3号楼805", province: "广东", part: "华南", image: "jinping", isvisited: false),
//Area(name: "长沙市芙蓉区车站北路225号蓉园西区9号楼1311", province: "湖南", part: "华中", image: "furong", isvisited: false),
//Area(name: "徐州市铜山区中国矿业大学梅二A4162", province: "江苏", part: "华东", image: "fangting", isvisited: false)
