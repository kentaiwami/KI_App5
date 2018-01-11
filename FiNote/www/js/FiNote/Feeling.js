/************************************************************
                        feeling.html
 ************************************************************/
var Feeling = {

  // タップしたリストのidを保存する
  data: {tap_id: 0},


  /**
   * 気分リストのツールバー左に表示するボタンを動的に変える
   * @param  {number} flag - 0なら映画追加画面、1なら映画詳細画面からの気分リスト
   * @return {string}      - ボタンのhtml
   */
  get_toolbar_feeling: function(flag) {
    if (flag === 0) {
      return '<ons-toolbar-button class="brown_color"><ons-icon class="brown_color" icon="ion-close-round"></ons-icon></ons-toolbar-button>';
    }else {
      return '<ons-back-button class="brown_color"></ons-back-button>';
    }
  },

  /**
   * 気分リストのコンテンツを表示する関数
   */
  show_contents: function(){
    //flagに応じてツールバーの戻る・閉じるボタンを動的に変える
    var toolbar_left = document.getElementById(ID.get_feeling_ID().toolbar);
    toolbar_left.innerHTML = '';
    toolbar_left.innerHTML = Feeling.get_toolbar_feeling(Global_variable.feeling_flag);

    // 詳細画面から表示した場合
    if (Global_variable.feeling_flag === 1) {
      document.getElementById(ID.get_feeling_ID().toolbar).setAttribute('onClick', 'Movies_detail.tap_feeling_back_button()');
    }

    //アラート表示後に自動フォーカスするためのイベントを登録する
    Feeling.feeling_input_name_addEvent();

    var nodata_message = document.getElementById(ID.get_feeling_ID().nodata_message);
    var feeling_list = document.getElementById(ID.get_feeling_ID().list);
    var length = Movieadd.userdata.feeling_name_list.length;
    var caution_message = document.getElementById(ID.get_feeling_ID().caution_message);

    feeling_list.innerHTML = '';

    if (length === 0) {
      //気分リストが空かつ詳細画面から遷移した気分リスト画面の場合
      if(Global_variable.feeling_flag === 1) {
        caution_message.innerHTML = '';
      }

      nodata_message.style.height = '100%';
      nodata_message.innerHTML = '感情を1件以上登録してください<br>(1件につき6文字以内)';
    }else {
      //気分リストが1件以上かつ詳細画面から遷移した気分リスト画面の場合
      if(Global_variable.feeling_flag === 1) {
        caution_message.innerHTML = '※ この画面から戻る際に気分リストが保存されます。';
      }

      nodata_message.style.height = '0%';
      nodata_message.innerHTML = '';

      //リスト表示
      feeling_list.innerHTML = '<ons-list-header>登録済みの気分</ons-list-header>';

      for(var i = 0; i < length; i++) {
        feeling_list.innerHTML += '<ons-list-item modifier="longdivider">'+
                                  '<div class="left">'+
                                  Movieadd.userdata.feeling_name_list[i]+
                                  '</div>'+

                                  '<div class="right">'+
                                  '<ons-button class="brown_bg_color_quiet" modifier="quiet" onClick="Feeling.tap_edit('+ i +')">'+
                                  '<ons-icon size="25px" icon="ion-edit"></ons-icon>'+
                                  '</ons-button>'+

                                  '<ons-button class="brown_bg_color_quiet" modifier="quiet" onClick="Feeling.tap_delete('+ i +')">'+
                                  '<ons-icon size="25px" icon="ion-trash-a"></ons-icon>'+
                                  '</ons-button>'+
                                  '</div>'+
                                  '</ons-list-item>';
      }
    }
  },


  /**
   * アラート表示後にフォーカスを当てる処理を行う
   */
  feeling_input_name_addEvent: function(){
    document.addEventListener('postshow', function(event) {
      if (event.target.id === ID.get_feeling_ID().add_dialog) {
        document.getElementById(ID.get_feeling_ID().add_button).setAttribute('disabled', 'disabled');
        document.getElementById(ID.get_feeling_ID().input).focus();
      }else if (event.target.id === ID.get_feeling_ID().edit_dialog) {
        document.getElementById(ID.get_feeling_ID().edit_input).focus();
      }
    });
  },


  /**
   * 気分を入力するアラートを表示してinputのvalueを初期化する
   */
  show_input_alert: function(){
    document.getElementById(ID.get_feeling_ID().add_dialog).show();

    var input_form = document.getElementById(ID.get_feeling_ID().input);
    input_form.value = '';
    input_form.addEventListener('keyup', Feeling.check_add_input_form);
  },


  /**
   * 気分の追加フォームの値を監視して登録ボタンの有効・無効を設定する関数
   */
  check_add_input_form: function(){
    var value = document.getElementById(ID.get_feeling_ID().input).value;
    var add_button = document.getElementById(ID.get_feeling_ID().add_button);

    if (value.replace(/\s+/g, '') !== '') {
      add_button.removeAttribute('disabled');
    }else {
      add_button.setAttribute('disabled');
    }
  },


  /**
   * 気分の変更フォームの値を監視して変更ボタンの有効・無効を設定する関数
   */
  check_edit_input_form: function(){
    var value = document.getElementById(ID.get_feeling_ID().edit_input).value;
    var change_button = document.getElementById(ID.get_feeling_ID().edit_button);

    if (value.replace(/\s+/g, '') !== '') {
      change_button.removeAttribute('disabled');
    }else {
      change_button.setAttribute('disabled');
    }
  },


  /**
   * アラートを閉じるor閉じてリストへ追加する関数
   * @param  {string} func_id   - cancel or add or change
   * @param  {string} dialog_id - feeling_add_dialog or feeling_edit_dialog
   */
  hide_input_alert: function(func_id, dialog_id){
    if (func_id === 'cancel') {
      document.getElementById(dialog_id).hide();
    }else if (func_id === 'add' ){
      var feeling_name = document.getElementById(ID.get_feeling_ID().input).value;
      feeling_name = feeling_name.replace(/\s+/g, '');

      //既出でない場合
      if (Movieadd.userdata.feeling_name_list.indexOf(feeling_name) === -1) {
        //リスト追加と表示
        Movieadd.userdata.feeling_name_list.push(feeling_name);
        Feeling.show_contents();

        //ラベルの更新(映画の追加画面からの気分リストの表示時はラベルの更新を行う)
        if (Global_variable.feeling_flag === 0) {
          Movieadd.update_labels();
        }

        document.getElementById(dialog_id).hide();

      //既出の場合
      }else {
        document.getElementById(dialog_id).hide();
        Utility.show_error_alert('登録エラー','既に登録済みです','OK');
      }
    }else {
      // changeの場合
      var value = document.getElementById(ID.get_feeling_ID().edit_input).value;
      if (Movieadd.userdata.feeling_name_list.indexOf(value) === -1) {
        Movieadd.userdata.feeling_name_list[Feeling.data.tap_id] = value;
        document.getElementById(ID.get_feeling_ID().edit_dialog).hide();
        Feeling.show_contents();
      }else {
        document.getElementById(dialog_id).hide();
        Utility.show_error_alert('登録エラー','既に登録済みです','OK');
      }
    }
  },


  /**
   * リストの編集ボタンをタップした際に、入力用のアラートを表示する
   * @param  {number} i - タップしたリストの配列の添え字
   */
  tap_edit: function(i) {
    Feeling.data.tap_id = i;

    var feeling_name_list = Movieadd.userdata.feeling_name_list;
    var edit_input = document.getElementById(ID.get_feeling_ID().edit_input);
    edit_input.value= feeling_name_list[Feeling.data.tap_id];

    document.getElementById(ID.get_feeling_ID().edit_dialog).show();
    edit_input.addEventListener('keyup', Feeling.check_edit_input_form);
  },


  /**
   * リストの削除ボタンをタップした際に、確認用のアラートを表示して削除を行う
   * @param  {number} i - タップしたリストの配列の添え字
   */
  tap_delete: function(i) {
    Feeling.data.tap_id = i;

    var feeling_name_list = Movieadd.userdata.feeling_name_list;
    var message = '「' + feeling_name_list[i] + '」を削除します';

    var func_cancel = function() {};
    var func_delete = function() {
      feeling_name_list.splice(i, 1);
      Feeling.show_contents();
      Movieadd.update_labels();
    };

    Utility.show_confirm_alert('気分の削除', message, ['キャンセル', '削除'], func_cancel, func_delete);
  }
};