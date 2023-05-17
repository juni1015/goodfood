<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<footer id="footer" class="bg-dark text-light p-4">

</footer>
<script>
  const date = new Date();
  console.log(date);
  console.log(date.getFullYear());
  const footer = document.getElementById("footer");
  footer.innerHTML = "<p>&copy; " + date.getFullYear() + "&nbsp; GOODFOOD  All rights reserved. </p>";
</script>