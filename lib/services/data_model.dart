// To parse this JSON data, do
//
//     final loginData = loginDataFromJson(jsonString);

import 'dart:convert';

LoginData loginDataFromJson(String str) => LoginData.fromJson(json.decode(str));

String loginDataToJson(LoginData data) => json.encode(data.toJson());

class LoginData {
  LoginData({
    this.sessionToken,
    this.authorizations,
  });

  String sessionToken;
  List<Authorization> authorizations;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        sessionToken:
            json["session_token"] == null ? null : json["session_token"],
        authorizations: json["authorizations"] == null
            ? null
            : List<Authorization>.from(
                json["authorizations"].map((x) => Authorization.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "session_token": sessionToken == null ? null : sessionToken,
        "authorizations": authorizations == null
            ? null
            : List<dynamic>.from(authorizations.map((x) => x.toJson())),
      };
}

class Authorization {
  Authorization({
    this.uid,
    this.labl,
    this.details,
    this.resoCat,
    this.moduleId,
  });

  String uid;
  String labl;
  Details details;
  ResoCat resoCat;
  String moduleId;

  factory Authorization.fromJson(Map<String, dynamic> json) => Authorization(
        uid: json["uid"] == null ? null : json["uid"],
        labl: json["labl"] == null ? null : json["labl"],
        details:
            json["details"] == null ? null : Details.fromJson(json["details"]),
        resoCat: json["reso_cat"] == null
            ? null
            : resoCatValues.map[json["reso_cat"]],
        moduleId: json["module_id"] == null ? null : json["module_id"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "labl": labl == null ? null : labl,
        "details": details == null ? null : details.toJson(),
        "reso_cat": resoCat == null ? null : resoCatValues.reverse[resoCat],
        "module_id": moduleId == null ? null : moduleId,
      };
}

class Details {
  Details({
    this.id,
    this.cre,
    this.del,
    this.rea,
    this.upd,
    this.group,
    this.link,
    this.enabled,
  });

  String id;
  bool cre;
  bool del;
  bool rea;
  bool upd;
  Group group;
  String link;
  bool enabled;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"] == null ? null : json["id"],
        cre: json["cre"] == null ? null : json["cre"],
        del: json["del"] == null ? null : json["del"],
        rea: json["rea"] == null ? null : json["rea"],
        upd: json["upd"] == null ? null : json["upd"],
        group: json["group"] == null ? null : groupValues.map[json["group"]],
        link: json["link"] == null ? null : json["link"],
        enabled: json["enabled"] == null ? null : json["enabled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "cre": cre == null ? null : cre,
        "del": del == null ? null : del,
        "rea": rea == null ? null : rea,
        "upd": upd == null ? null : upd,
        "group": group == null ? null : groupValues.reverse[group],
        "link": link == null ? null : link,
        "enabled": enabled == null ? null : enabled,
      };
}

enum Group { SYS, PUBLIC, HOME }

final groupValues =
    EnumValues({"home": Group.HOME, "public": Group.PUBLIC, "sys": Group.SYS});

enum ResoCat { TBL_ACCESS, COMPLEX_DATA_FLOW, WEB_MAPS }

final resoCatValues = EnumValues({
  "complex_data_flow": ResoCat.COMPLEX_DATA_FLOW,
  "tbl_access": ResoCat.TBL_ACCESS,
  "web_maps": ResoCat.WEB_MAPS
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
