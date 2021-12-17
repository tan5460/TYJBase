//
//  YJLoginViewController.swift
//  YJAwesome
//
//  Created by YJ-T on 2021/12/8.
//

import UIKit

class YJLoginViewController: YJBaseViewController {
    
    private var scrollView: UIScrollView!
    private var loginTypeSegment: YJLoginTypeSegmentView!
    private var accountInputView: YJLoginAccountInputView!
    private var verifyCodeInputView: YJLoginVerifyCodeInputView!
    private var passwordInputView: YJLoginPasswordInputView!
    private var forgetPasswordBtn: UIButton!
    private var loginBtn: UIButton!
    private var protocolBtn: UIButton!
    private var protocolLabel: UILabel!
    private var weChatBtn: UIButton!
    private var weChatLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "登录"
        createViews()
        addViewsAction()
        changeLoginType(isVerifyCodeType: true, animate: false)
        verifyInputTextLength()
    }
    
    func addViewsAction() {
        loginTypeSegment.changeSelectedIndexClosure = {[weak self] selectedIndex in
            self?.changeLoginType(isVerifyCodeType: selectedIndex == 0)
        }
        accountInputView.inputTextDidChangeClosure = {[weak self] text in
            self?.verifyInputTextLength()
        }
        verifyCodeInputView.inputTextDidChangeClosure = {[weak self] text in
            self?.verifyInputTextLength()
        }
        passwordInputView.inputTextDidChangeClosure = {[weak self] text in
            self?.verifyInputTextLength()
        }
    }
    
    func changeLoginType(isVerifyCodeType: Bool, animate: Bool = true) {
        loginBtn.snp.remakeConstraints { make in
            make.left.right.equalTo(accountInputView)
            make.height.equalTo(40)
            if isVerifyCodeType {
                make.top.equalTo(verifyCodeInputView.snp.bottom).offset(40)
            } else {
                make.top.equalTo(forgetPasswordBtn.snp.bottom).offset(40)
            }
        }
        UIView.animate(withDuration: animate ? 0.25 : 0) {
            self.verifyCodeInputView.alpha = isVerifyCodeType ? 1 : 0
            self.passwordInputView.alpha = isVerifyCodeType ? 0 : 1
            self.forgetPasswordBtn.alpha = isVerifyCodeType ? 0 : 1
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }
    
    func verifyInputTextLength() {
        loginBtn.isEnabled = false
        loginBtn.backgroundColor = UIColor(hex: 0xEBEBEB)
        //输入的手机号长度
        if let count = accountInputView.textField.text?.count, count < 11 {
            return
        }
        if loginTypeSegment.selectedIndex == 0 {
            //输入的验证码长度
            if let count = verifyCodeInputView.textField.text?.count, count < 4 {
                return
            }
        } else {
            //输入的密码长度
            if let count = passwordInputView.textField.text?.count, count < 6 {
                return
            }
        }
        loginBtn.isEnabled = true
        loginBtn.backgroundColor = UIColor(hex: 0xB79B5B)
    }
    
    @objc func protocolBtnAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc func loginBtnAction(sender: UIButton) {
        YJActionCaptcha().start()
    }
    
}

private extension YJLoginViewController {
    
    func createViews() {
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        loginTypeSegment = YJLoginTypeSegmentView()
        scrollView.addSubview(loginTypeSegment)
        loginTypeSegment.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.left.right.equalTo(0)
            make.height.equalTo(40)
            make.width.equalTo(kScreenWidth)
        }
        
        accountInputView = YJLoginAccountInputView()
        accountInputView.imageView.image = R.image.login_account()
        scrollView.addSubview(accountInputView)
        accountInputView.snp.makeConstraints { make in
            make.left.equalTo(35)
            make.right.equalTo(-35)
            make.top.equalTo(loginTypeSegment.snp.bottom).offset(50)
            make.height.equalTo(40)
        }
        
        verifyCodeInputView = YJLoginVerifyCodeInputView()
        verifyCodeInputView.imageView.image = R.image.login_verifyCode()
        scrollView.addSubview(verifyCodeInputView)
        verifyCodeInputView.snp.makeConstraints { make in
            make.left.right.height.equalTo(accountInputView)
            make.top.equalTo(accountInputView.snp.bottom).offset(40)
        }
        
        passwordInputView = YJLoginPasswordInputView()
        passwordInputView.imageView.image = R.image.login_password()
        scrollView.addSubview(passwordInputView)
        passwordInputView.snp.makeConstraints { make in
            make.left.right.height.equalTo(accountInputView)
            make.top.equalTo(accountInputView.snp.bottom).offset(40)
        }
        
        forgetPasswordBtn = UIButton(type: .custom)
        forgetPasswordBtn.titleLabel?.font = .systemFont(ofSize: 12)
        forgetPasswordBtn.setTitle("忘记密码", for: .normal)
        forgetPasswordBtn.setTitleColor(UIColor(hex: 0xB79B5B), for: .normal)
        forgetPasswordBtn.contentHorizontalAlignment = .right
        scrollView.addSubview(forgetPasswordBtn)
        forgetPasswordBtn.snp.makeConstraints { make in
            make.top.equalTo(passwordInputView.snp.bottom)
            make.right.equalTo(passwordInputView)
            make.width.equalTo(70)
            make.height.equalTo(40)
        }
        
        loginBtn = UIButton(type: .custom)
        loginBtn.titleLabel?.font = .systemFont(ofSize: 15)
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.backgroundColor = UIColor(hex: 0xB79B5B)
        loginBtn.layer.cornerRadius = 5
        loginBtn.layer.masksToBounds = true
        loginBtn.addTarget(self, action: #selector(loginBtnAction(sender:)), for: .touchUpInside)
        scrollView.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { make in
            make.left.right.equalTo(accountInputView)
            make.top.equalTo(verifyCodeInputView.snp.bottom).offset(40)
            make.height.equalTo(40)
        }
        
        protocolBtn = UIButton(type: .custom)
        protocolBtn.setImage(R.image.login_unselected(), for: .normal)
        protocolBtn.setImage(R.image.login_selected(), for: .selected)
        protocolBtn.addTarget(self, action: #selector(protocolBtnAction(sender:)), for: .touchUpInside)
        scrollView.addSubview(protocolBtn)
        protocolBtn.snp.makeConstraints { make in
            make.top.equalTo(loginBtn.snp.bottom).offset(30)
            make.left.equalTo(loginBtn)
            make.width.height.equalTo(30)
        }
        
        let attrString = NSMutableAttributedString(string: "我已阅读并同意用户协议和隐私协议")
        attrString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSMakeRange(0, attrString.length))
        attrString.addAttribute(.foregroundColor, value: UIColor(hex: 0x676767), range: NSMakeRange(0, attrString.length))
        attrString.addAttribute(.foregroundColor, value: UIColor(hex: 0xB79B5B), range: NSMakeRange(7, 4))
        attrString.addAttribute(.foregroundColor, value: UIColor(hex: 0xB79B5B), range: NSMakeRange(attrString.length - 4, 4))
        protocolLabel = UILabel()
        protocolLabel.attributedText = attrString
        scrollView.addSubview(protocolLabel)
        protocolLabel.snp.makeConstraints { make in
            make.centerY.equalTo(protocolBtn)
            make.left.equalTo(protocolBtn.snp.right)
            make.right.equalTo(loginBtn)
        }
        
        weChatBtn = UIButton(type: .custom)
        weChatBtn.setImage(R.image.login_weChat(), for: .normal)
        scrollView.addSubview(weChatBtn)
        weChatBtn.snp.makeConstraints { make in
            make.top.equalTo(protocolLabel.snp.bottom).offset(20)
            make.centerX.equalTo(view.snp.centerX)
            make.width.height.equalTo(50)
        }
        
        weChatLabel = UILabel()
        weChatLabel.text = "微信"
        weChatLabel.font = .systemFont(ofSize: 15)
        weChatLabel.textColor = UIColor(hex: 0x676767)
        scrollView.addSubview(weChatLabel)
        weChatLabel.snp.makeConstraints { make in
            make.top.equalTo(weChatBtn.snp.bottom).offset(10)
            make.centerX.equalTo(weChatBtn.snp.centerX)
            make.bottom.equalTo(0)
        }
    }
    
    
    
}



fileprivate class YJLoginTypeSegmentView: UIView {
    
    private var smsLoginBtn: UIButton!
    private var passwordLoginBtn: UIButton!
    private var indicatorLine: UIView!
    
    var selectedIndex: Int = 0
    var changeSelectedIndexClosure: ((_ selectedIndex: Int) -> Void)?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        smsLoginBtnAction(sender: smsLoginBtn)
    }
    
    private func createViews() {
        smsLoginBtn = UIButton(type: .custom)
        smsLoginBtn.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        smsLoginBtn.setTitle("短信登录", for: .normal)
        smsLoginBtn.setTitleColor(UIColor(hex: 0xB4B4B4), for: .normal)
        smsLoginBtn.setTitleColor(UIColor(hex: 0x333333), for: .selected)
        smsLoginBtn.addTarget(self, action: #selector(smsLoginBtnAction(sender:)), for: .touchUpInside)
        addSubview(smsLoginBtn)
        smsLoginBtn.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(0)
            make.right.equalTo(snp.centerX)
        }
        
        passwordLoginBtn = UIButton(type: .custom)
        passwordLoginBtn.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        passwordLoginBtn.setTitle("密码登录", for: .normal)
        passwordLoginBtn.setTitleColor(UIColor(hex: 0xB4B4B4), for: .normal)
        passwordLoginBtn.setTitleColor(UIColor(hex: 0x333333), for: .selected)
        passwordLoginBtn.addTarget(self, action: #selector(passwordLoginBtnAction(sender:)), for: .touchUpInside)
        addSubview(passwordLoginBtn)
        passwordLoginBtn.snp.makeConstraints { make in
            make.top.right.bottom.equalTo(0)
            make.left.equalTo(snp.centerX)
        }
        
        indicatorLine = UIView()
        indicatorLine.backgroundColor = UIColor(hex: 0xB79B5B)
        indicatorLine.layer.cornerRadius = 1
        indicatorLine.layer.masksToBounds = true
        addSubview(indicatorLine)
        indicatorLine.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(2)
            make.bottom.equalTo(0)
            make.centerX.equalTo(smsLoginBtn)
        }
    }
    
    @objc private func smsLoginBtnAction(sender: UIButton) {
        selectedIndex = 0
        smsLoginBtn.isSelected = true
        passwordLoginBtn.isSelected = false
        indicatorLine.snp.remakeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(2)
            make.bottom.equalTo(0)
            make.centerX.equalTo(smsLoginBtn)
        }
        UIView.animate(withDuration: 0.15) {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
        changeSelectedIndexClosure?(selectedIndex)
    }
    
    @objc private func passwordLoginBtnAction(sender: UIButton) {
        selectedIndex = 1
        smsLoginBtn.isSelected = false
        passwordLoginBtn.isSelected = true
        indicatorLine.snp.remakeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(2)
            make.bottom.equalTo(0)
            make.centerX.equalTo(passwordLoginBtn)
        }
        UIView.animate(withDuration: 0.25) {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
        changeSelectedIndexClosure?(selectedIndex)
    }
}


fileprivate class YJLoginAccountInputView: UIView, UITextFieldDelegate {
    var imageView: UIImageView!
    var textField: YJLoginTextField!
    var line: UIView!
    
    var inputTextDidChangeClosure: ((_ text: String) -> Void)?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldValueChanged), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    func createViews() {
        imageView = UIImageView()
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.equalTo(5)
            make.centerY.equalTo(snp.centerY)
            make.width.height.equalTo(20)
        }
        
        textField = YJLoginTextField()
        textField.font = .systemFont(ofSize: 14)
        textField.textColor = UIColor(hex: 0x333333)
        textField.placeholder = "请输入您的手机号"
        textField.keyboardType = .numberPad
        textField.delegate = self
        textField.clearButtonMode = .whileEditing
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(5)
            make.right.equalTo(-5)
            make.top.bottom.equalTo(0)
        }
        
        line = UIView()
        line.backgroundColor = UIColor(hex: 0xB4B4B4)
        addSubview(line)
        line.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(0.5)
        }
    }
    
    @objc func textFieldValueChanged(sender: Notification) {
        if let object = sender.object as? UITextField, object == textField {
            inputTextDidChangeClosure?(textField.text ?? "")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text! as NSString
        let newString = text.replacingCharacters(in: range, with: string)
        if newString.count > 11 {
            return false
        }
        return true
    }
}

fileprivate class YJLoginPasswordInputView: YJLoginAccountInputView {
    
    private var showPasswordBtn: UIButton!
    
    override func createViews() {
        super.createViews()
        
        showPasswordBtn = UIButton(type: .custom)
        showPasswordBtn.setImage(R.image.login_password_hide(), for: .normal)
        showPasswordBtn.setImage(R.image.login_password_display(), for: .selected)
        showPasswordBtn.addTarget(self, action: #selector(showPasswordBtnAction(sender:)), for: .touchUpInside)
        addSubview(showPasswordBtn)
        showPasswordBtn.snp.makeConstraints { make in
            make.right.equalTo(-5)
            make.centerY.equalTo(snp.centerY)
            make.width.height.equalTo(30)
        }
        
        textField.placeholder = "请输入您的密码（长度6到16位）"
        textField.isSecureTextEntry = true
        textField.keyboardType = .asciiCapable
        textField.snp.remakeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(5)
            make.right.equalTo(showPasswordBtn.snp.left).offset(-5)
            make.top.bottom.equalTo(0)
        }
    }
    
    @objc func showPasswordBtnAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        textField.isSecureTextEntry = !sender.isSelected
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text! as NSString
        let newString = text.replacingCharacters(in: range, with: string)
        if newString.count > 16 {
            return false
        }
        return true
    }
}

fileprivate class YJLoginVerifyCodeInputView: YJLoginAccountInputView {
    
    private var getVerifyCodeBtn: UIButton!
    
    override func createViews() {
        super.createViews()
        
        getVerifyCodeBtn = UIButton(type: .custom)
        getVerifyCodeBtn.titleLabel?.font = .systemFont(ofSize: 15)
        getVerifyCodeBtn.setTitle("获取验证码", for: .normal)
        getVerifyCodeBtn.backgroundColor = UIColor(hex: 0xB79B5B)
        getVerifyCodeBtn.layer.cornerRadius = 5
        getVerifyCodeBtn.layer.masksToBounds = true
        addSubview(getVerifyCodeBtn)
        getVerifyCodeBtn.snp.makeConstraints { make in
            make.right.equalTo(-5)
            make.centerY.equalTo(snp.centerY)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        textField.placeholder = "请输入短信验证码"
        textField.snp.remakeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(5)
            make.right.equalTo(getVerifyCodeBtn.snp.left).offset(-5)
            make.top.bottom.equalTo(0)
        }
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text! as NSString
        let newString = text.replacingCharacters(in: range, with: string)
        if newString.count > 6 {
            return false
        }
        return true
    }
}

fileprivate class YJLoginTextField: UITextField {
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
}
